#include <math.h>
#include <stdio.h>

int main(void) {
  int a;
  double b;

  a = 10;
  b = 20 + cos((double)a);
  printf("%f\n", b);

  return 0;
}
