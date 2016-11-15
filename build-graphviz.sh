# Copyright 2014 George King. Permission to use this file is granted in license-gloss.txt.

# last verified: graphviz 2.38, mac 10.12.

set -ex

#./autogen.sh # does not work on mac without updated gnu tools.

# using _build directory does not work.

./configure \
--prefix=/usr/local/graphviz \
"$@"

make clean
make

set +x
echo
echo 'build complete; run make install.'
