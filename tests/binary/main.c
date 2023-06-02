#include <stdint.h>
#include <stdio.h>

#include "tests/binary/lib_c.h"
#include "tests/binary/lib_cpp.h"

int32_t main(int32_t argument_count, char** arguments) {
  printf("%s\n", GetMessageC());
  printf("%s\n", GetMessageCPP());

  return 0;
}
