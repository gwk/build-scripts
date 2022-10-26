#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

# build ruby using clang.
# requires that openssl was built from source using build-openssl.sh.

$(dirname $0)/build-with-clang.sh \
--prefix=/usr/local/ruby \
--with-openssl-dir=/usr/local/ssl \
