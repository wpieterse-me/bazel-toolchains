#!/bin/bash

clear

~/Downloads/pcsx2-v1.7.4549-linux-AppImage-64bit-Qt.AppImage -batch -nogui -fastboot -elf $(pwd)/bazel-bin/tests/ps2/ps2_ee.elf
