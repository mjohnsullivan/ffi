struct Place
{
    double latitude;
    double longitude;
    char *name;
};

struct Place create_place(char *name, double latitude, double longitude);

char *hello_world();
char *reverse(char *str, int length);