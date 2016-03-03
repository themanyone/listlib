/* 
 * Copyright (C) 2010, 2013 by Henry Kroll III, www.thenerdshow.com
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#ifndef _LISTLIB
#define _LISTLIB
#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <strings.h>
#include <stdlib.h>
#include <errno.h>
#ifdef __MINGW_H
#define strcasecmp stricmp
#endif
#define _STR(a) #a
#define STR(a) _STR(a)
#define TRY(a) if (!(a)){ \
    perror(__FILE__":"STR(__LINE__));exit(1);}
#define DUP(f, s) strcpy(f(strlen(s) + 1), s)
#define ALT(f, s) s = DUP(f, s)
#define ForEach(s, t) void *t; for (int ForEach=0;(t = s[ForEach]);ForEach++)
#define FREE(a) if(a){free(a);a=NULL;}
#define ERR(...) fprintf (stderr, __VA_ARGS__);exit (1)
#define DEBUG 0
#define debug(...) if(DEBUG)fprintf(stderr,__VA_ARGS__)
enum {CREATE,SPLIT,COPY,APPEND,PREPEND,INSERT,REVERSE,
HELP,LEN,INDEX,GET,POP,REMOVE,SORT,PRINT,DESTROY,
_GET_PTR,_FIND_PTR};
#define PUSH PREPEND
/* Initialize linked list */
struct list_e {
    struct list_e *next;
    char *data;
    };
typedef struct list_e *LinkedList;
/* declare psfunc as pointer to function returning int */
typedef int (*psfunc)(const char *,const char *);
/* function prototypes */
void *list (LinkedList, int, ...);
#endif /* _LISTLIB */