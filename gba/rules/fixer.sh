#!/bin/bash

# --- begin runfiles.bash initialization v3 ---
# Copy-pasted from the Bazel Bash runfiles library v3.
set -uo pipefail; set +e; f=bazel_tools/tools/bash/runfiles/runfiles.bash
source "${RUNFILES_DIR:-/dev/null}/$f" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "${RUNFILES_MANIFEST_FILE:-/dev/null}" | cut -f2- -d' ')" 2>/dev/null || \
  source "$0.runfiles/$f" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "$0.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "$0.exe.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \
  { echo>&2 "ERROR: cannot find $f"; exit 1; }; f=; set -e
# --- end runfiles.bash initialization v3 ---

TOOL_OBJCOPY="$(rlocation com_github_wpieterse-me_bazel-toolchain-gba-archive/devkitARM/bin/arm-none-eabi-objcopy)"
TOOL_GBAFIX="$(rlocation com_github_wpieterse-me_bazel-toolchain-gba-archive/tools/bin/gbafix)"

INPUT_FILE=$1
OUTPUT_FILE=$2

${TOOL_OBJCOPY} -v -O binary $INPUT_FILE $OUTPUT_FILE
${TOOL_GBAFIX} $OUTPUT_FILE
