# Copyright 2011 George King. Permission to use this file is granted in license-gloss.txt.

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
