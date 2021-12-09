#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

set -ex

$(dirname $0)/build-with-clang.sh \
--prefix=/usr/local/llvm-tip \
--enable-libcpp \
--enable-optimized \
--enable-assertions \
--enable-targets='x86,x86_64,arm,arm64,aarch64,cpp'
