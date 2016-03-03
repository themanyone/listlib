NAME=listlib
BUILD_TARGETS=$(NAME)_test.o fire_ice.o
BUILD_LIBS=$(NAME).o
INCLUDES+=-I.
LDFLAGS+=-Llibs
LIBEXT=.so
CFLAGS+=-g -Wall -pipe -O2 -std=c99
# detect if cross-compiling to windows
ifneq (,$(findstring win,$(CC)))
	LIBEXT=.dll
	LDFLAGS=
	EXT=.exe
	# if make shared, use dll.def files for exports
	ifneq (,$(findstring shared,$(MAKECMDGOALS)))
		DEFS=$(NAME).def
	endif
endif

PREFIX=/usr/local
LIBDIR=$(PREFIX)/lib64
BINDIR=$(PREFIX)/bin

#~ make foo.c
%.c : %.anch
	anchor -q "$<" > "$@"

#~ "make foo.o"
%.o : %.c #~ make foo.c if needed
	$(CC) $(CFLAGS) -c "$<" -o "$@" $(INCLUDES)

#~ generic "make foo"
% : %.o $(BUILD_LIBS)
	$(CC) $(BUILD_LIBS) $(DEFS) "$<" -o "bin/$*$(EXT)" $(LDFLAGS)

#~ "make foo.so" shared library
%.so : CFLAGS+=-fPIC
%.so : LDFLAGS=-shared
%.so : %.o
	$(CC) $(CFLAGS) $(LDFLAGS) $< -Wl,-soname,"lib$@.1" -o "libs/lib$@.1.0.1"
	ln -sf "lib$@.1.0.1" "libs/lib$@.1"
	ln -sf "lib$@.1.0.1" "libs/lib$@"

%.dll : LDFLAGS+=-shared
%.dll : %.o
	$(CC) $(CFLAGS) $(LDFLAGS) $< -o "$@"

#~ defauilt rule builds target[s] [libs]
all: $(BUILD_TARGETS:.o=)

debug: CFLAGS+=-g -pedantic -O0
debug: all

s:
	scite Makefile *.h *.anch&

html:
	tml README.tml > README.html

shared: BUILD_LIBS :=
ifeq (,$(findstring win,$(CC)))
shared: LDFLAGS+=-llistlib
endif
shared: $(NAME)$(LIBEXT) all
	
clean:
	rm -f $(BUILD_TARGETS) $(BUILD_TARGETS:.o=) $(BUILD_TARGETS:.o=.c) \
	$(BUILD_LIBS) $(BUILD_LIBS:.o=.dll) $(BUILD_LIBS:.o=.c)
	rm -f libs/*
	rm -f bin/*

pub:
	-strip $(BUILD_TARGETS:.o=)
	-i686-pc-mingw32-strip $(BUILD_TARGETS:.o=.exe)

print-%: ; @echo $*=$($*)

.SECONDARY:
