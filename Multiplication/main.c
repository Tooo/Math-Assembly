
#include <stdio.h>

unsigned times(unsigned, unsigned);

void main () {
    unsigned a = 30000;
    unsigned b = 2000;
    printf("The product of %u and %u is %u.\n", a, b, times(a,b));
    return;
}

