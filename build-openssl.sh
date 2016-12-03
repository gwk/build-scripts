# Copyright 2014 George King. Permission to use this file is granted in license-gloss.txt.

# build openssl for osx using clang.

set -ex

./Configure darwin64-x86_64-cc "$@"

make clean
make # -j8 fails for openssl-1.0.2a; osx 10.10.4 tools (gnu make 3.81).

set +x
echo
echo 'build complete; run make install.'
