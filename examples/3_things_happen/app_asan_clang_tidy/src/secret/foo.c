#include "foo.h"
#include <stdint.h>
#include <stdio.h>

void foo(const char *txt)
{
    printf("\n==== Hello %c%c%c%c%c%c%c ====\n", txt[0], txt[1], txt[2], txt[3], txt[4], txt[5], txt[6]);
}
