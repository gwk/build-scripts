# Copyright 2015 George King. Permission to use this file is granted in license-gloss.txt.

set -ex


# unlike many build scripts, we are obliged to run configure from the root dir;
# otherwise, recursive make in lib/py fails.

./configure \
CC=clang CXX=clang++

make clean
make -j8

set +x
echo
echo 'build complete; run make install.'

