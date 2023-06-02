#!/bin/bash

clear

dosbox-x -fastlaunch -silent -log-con $(pwd)/bazel-bin/tests/msdos/msdos.exe -exit
