title: ListLib
description: Linked list library for C
-------------body-------------
=ListLib=

ListLib is a small library for working with linked-lists.

ListLib is part of [http://anch.org/tml.html TML project], the application we made to generate web pages from text wiki markup. [programs/listlib.zip Listlib] creates a stack to store nested tag values and file names for backlinks. [programs/listlib.zip Listlib] handles multiple lists. ListLib has methods to split strings into lists and sort them, but it also works on other types of data or structures.

The ListLib library is one monolithic, polymorphic function cleverly named, "list". The main thing to remember is that POP pulls an allocated structure out of the list, with the consequence that we have to explicitly FREE it (see example below). To use [programs/listlib.zip Listlib], put `#include "listlib.h"` at the top of the file. Use the enum values, PRINT, DESTROY, etc. to access the various methods. For help, `puts (list(NULL,HELP));`

[programs/listlib.zip Listlib] is released under the terms of the [https://www.gnu.org/copyleft/gpl.html GNU Public license].

{{{
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
}}}

==Building Listlib==

Compiling listlib is simple once the dependencies have been installed.
    * TML is needed to build the HTML documentation.
    * Anchor is required to build the C sources.
After that, just run `make`.
