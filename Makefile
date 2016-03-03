NAME=listlib
BUILD_TARGETS=$(NAME)_test.o fire_ice.o
#~ BUILD_LIBS=mylib1.o mylib2.o
BUILD_LIBS=$(NAME).o
INCLUDES=-I.
LDFLAGS=
CFLAGS=-g -Wall -pipe -O2 -std=c99
MING=/usr/bin/i686-pc-mingw32-gcc

#~ make foo.c
%.c : %.anch
	anchor -q "$<" > "$@"

#~ "make foo.o"
%.o : %.c #~ make foo.c if needed
	$(CC) $(CFLAGS) -c "$<" -o "$@" $(INCLUDES)

#~ generic "make foo"
% : %.o $(BUILD_LIBS)
	$(CC) $(BUILD_LIBS) "$<" -o "$*$(EXT)" $(LDFLAGS)

#~ "make foo.so" shared library
%.so : CFLAGS+=-fPIC
%.so : LDFLAGS=-shared
%.so : %.o
	$(CC) $(CFLAGS) $(LDFLAGS) $< -Wl,-soname,"lib$@.1" -o "libs/lib$@.1.0.1"
	ln -sf "lib$@.1.0.1" "libs/lib$@.1"
	ln -sf "lib$@.1.0.1" "libs/lib$@"

#~ defauilt rule builds target[s] [libs]
all: $(BUILD_TARGETS:.o=)

#~ other targets
win: CC=$(MING)
win: EXT=.exe
win: all

#~ build some other target including an extra shared lib
other: CFLAGS+=-g -pedantic -O0
other: $(BUILD_LIBS:.o=.so) rec.so
	$(MAKE) train CFLAGS="-g -O0" BUILD_LIBS= LDFLAGS="-lpulse -lpulse-simple -Llibs $(addprefix -l,$(BUILD_LIBS:.o=) rec)"

debug: CFLAGS+=-g -pedantic -O0
debug: all

%.asm : %.o
	objdump -Sx $< > $@

s:
	scite Makefile *.h *.anch&

doc:
	tml README.md > README.html

shared: LDFLAGS+=-Llibs -llistlib
shared: $(NAME).so $(BUILD_TARGETS:.o=)

clean:
	rm -f $(BUILD_TARGETS) $(BUILD_TARGETS:.o=)  $(BUILD_TARGETS:.o=.c) $(BUILD_TARGETS:.o=.exe) $(BUILD_LIBS) *.asm
	rm -f libs/*

pub:
	-strip $(BUILD_TARGETS:.o=)
	-i686-pc-mingw32-strip $(BUILD_TARGETS:.o=.exe)
    
.SECONDARY:
