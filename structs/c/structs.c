#include <stdio.h>
#include <stdlib.h>
#include "structs.h"

int main()
{
    struct Place place;
    place = create_place("My Home", 1.0, 2.0);
    printf("The name of my place is %s\n", place.name);

    printf("%s\n", hello_world());
    printf("%s\n", reverse("backwards", 9));
    return 0;
}

struct Place create_place(char *name, double latitude, double longitude)
{
    struct Place place;
    place.name = name;
    place.latitude = latitude;
    place.longitude = longitude;
    return place;
}

char *hello_world()
{
    return "Hello World";
}

char *reverse(char *str, int length)
{
    char *reversed_str = (char *)malloc((length + 1) * sizeof(char));
    for (int i = 0; i < length; i++)
    {
        reversed_str[length - i - 1] = str[i];
    }
    reversed_str[length] = '\0';
    return reversed_str;
}