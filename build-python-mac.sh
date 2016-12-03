# Copyright 2011 George King. Permission to use this file is granted in license-gloss.txt.

# build python using clang.
# --enable-framework is required by some modules, particularly matplotlib.
# optional arguments:
# --with-pydebug

set -e
$(dirname $0)/build-with-clang.sh \
CFLAGS='-Wno-unused-value -Wno-empty-body -Wno-deprecated-declarations -Wno-tautological-compare -Qunused-arguments' \
--prefix=/usr/local/py \
--enable-framework=/usr/local/py \
"$@"


echo "NOTE: to set up pip log and http cache directories correctly for this user, run:"
echo "$ sudo -H make install"
