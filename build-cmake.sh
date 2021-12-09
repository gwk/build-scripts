#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

set -ex

../configure \
--prefix=/usr/local/cmake \
"$@"

make clean
make -j8

set +x
echo
echo 'build complete; run make install.'
