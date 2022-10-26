#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

# build openssl for osx using clang.

set -ex

./Configure darwin64-x86_64-cc "$@"

make clean
make # -j8 fails for openssl-1.0.2a; osx 10.10.4 tools (gnu make 3.81).

set +x
echo
echo 'Build complete; run make install.'
echo "Then run: py -c 'import ssl; print(ssl.OPENSSL_VERSION)'"

#https://rvm.io/support/fixing-broken-ssl-certificates
#cert_file="$( openssl version -d | awk -F'"' '{print $2}' )/cert.pem"
#mkdir -p "${cert_file%/*}"
#security find-certificate -a -p /Library/Keychains/System.keychain > "$cert_file"
#security find-certificate -a -p /System/Library/Keychains/SystemRootCertificates.keychain >> "$cert_file"
