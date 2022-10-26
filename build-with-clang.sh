#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

# configure with clang and any additional options, then run make clean all.

set -ex

../configure \
CC=clang CXX=clang++ \
"$@"

make clean
make -j6

set +x
echo
echo 'build complete; run make install as necessary.'
