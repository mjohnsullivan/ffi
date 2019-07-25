#include <stdio.h>
#include <string.h>
#include "primitives.h"

int main()
{
    // struct SomeData someData;

    printf("3 + 5 = %d\n", sum(3, 5));
    // someData = get_some_data(42);
    // printf("Value of data in struct is %d\n", someData.some_int);
    return 0;
}

int sum(int a, int b)
{
    return a + b;
}

/* 
struct SomeData get_some_data(int some_int)
{
    struct SomeData some_data;
    some_data.some_int = some_int;
    // strcpy(some_data.some_str, "This is some data");
    return some_data;
}
*/