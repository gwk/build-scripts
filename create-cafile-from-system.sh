#!/bin/sh
# Dedicated to the public domain under CC0: https://creativecommons.org/publicdomain/zero/1.0/.

set -e

cafile=/usr/local/ssl/cert.pem
echo "cafile: $cafile"
security find-certificate -a -p /Library/Keychains/System.keychain > $cafile
security find-certificate -a -p /System/Library/Keychains/SystemRootCertificates.keychain >> $cafile
