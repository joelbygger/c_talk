#include "foo.h"
#include <stdint.h>
#include <stdio.h>

void foo(const char *txt)
{
    printf("\n==== Hello %s ==== %c\n", txt, txt[0]);
}
