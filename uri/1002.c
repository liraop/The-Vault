#include <stdio.h>
#include <math.h>
int main(void)
{
    double a;
    double n = 3.14159;
    double area;

    scanf("%lf", &a);

    area = n * pow(a,2);
    printf("A=%.4lf\n", area);

    return 0;
}
