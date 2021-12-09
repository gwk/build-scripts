set -e

cafile=/usr/local/ssl/cert.pem
echo "cafile: $cafile"
security find-certificate -a -p /Library/Keychains/System.keychain > $cafile
security find-certificate -a -p /System/Library/Keychains/SystemRootCertificates.keychain >> $cafile
