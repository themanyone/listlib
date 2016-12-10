# ListLib

ListLib is a free small C library for working with linked-lists.

[Listlib](programs/listlib.zip) is part of the [TML project](//anch.org/tml.html), the application we made to generate web pages from text wiki markup. [Listlib](programs/listlib.zip) creates a stack to store nested tag values and file names for backlinks. [programs/listlib.zip Listlib] handles multiple lists. [Listlib](programs/listlib.zip) has methods to split strings into lists and do things with them.

The ListLib library is one monolithic, polymorphic function cleverly named, "list". The main thing to remember is that POP pulls an allocated structure out of the list, with the consequence that we have to explicitly FREE it (see example below). To use [Listlib](programs/listlib.zip), put `#include "listlib.h"` at the top of the file. Use the enum values, PRINT, DESTROY, etc. to access the various methods. For help, `puts (list(NULL,HELP));`

[Listlib](//github.com/themanyone/listlib) is released under the terms of the [//www.gnu.org/copyleft/gpl.html GNU Public license].

```
#include "listlib.h"
int main (void) {
    LinkedList myList;
    char *tmp, s[] = "I like my cheese";
    myList = list (NULL,SPLIT,s," ");
    printf ("Move '%s' to the beginning:\n",
        tmp = (char*)list(myList,POP,2));
    myList = list (myList,PREPEND,tmp);
    FREE(tmp); /* POP must be FREE'd */
    list (myList,PRINT,1);
    list (myList,DESTROY);
}
/* output:
Split: I like my cheese
Move 'my' to the beginning:
0. my
1. I
2. like
3. cheese
*/
```

## Building Listlib

Compiling listlib is simple once dependencies have been installed.
    * [TML](//anch.org/tml.html) is needed to build the HTML documentation.
    * [Anchor](//github.com/themanyone/anch) is required to build the C sources.
After that, just run `make`.
