# Copyright 2014 George King. Permission to use this file is granted in license-gloss.txt.

# build ruby using clang.
# requires that openssl was built from source using build-openssl.sh.

$(dirname $0)/build-with-clang.sh \
--prefix=/usr/local/ruby \
--with-openssl-dir=/usr/local/ssl \
