#include <stdint.h>
#include <stdio.h>

#include "tests/binary/lib_c.h"
#include "tests/binary/lib_cpp.h"

int32_t main(int32_t argument_count, char** arguments) {
  for(int32_t counter = 0; counter < 32; counter++) {
    printf("%s\n", GetMessageC());
    printf("%s\n", GetMessageCPP());
  }

  printf("\n\n\n--- DONE ---\n\n\n");

  return 0;
}
