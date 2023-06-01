#include <stdint.h>
#include <stdio.h>

#include "library.h"

int32_t main(int32_t argument_count, char** arguments) {
  printf("%s\n", GetMessage());

  return 0;
}
