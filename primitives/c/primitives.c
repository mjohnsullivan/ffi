#include <stdlib.h>
#include <stdio.h>
#include "primitives.h"

int main()
{
    printf("3 + 5 = %d\n", sum(3, 5));
    int *mult = multiply(3, 5);
    printf("3 * 5 = %d\n", *mult);
    free(mult);
    int sub_num = 3;
    printf("3 - 5 = %d\n", subtract(&sub_num, 5));
    return 0;
}

int sum(int a, int b)
{
    return a + b;
}

int *multiply(int a, int b)
{
    int *mult = (int *)malloc(sizeof(int));
    *mult = a * b;
    return mult;
}

int subtract(int *a, int b)
{
    return *a - b;
}