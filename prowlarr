#!/bin/bash
##Requires docker-diag-tools

##Prowlarr

##Copy to Docker for OpenSSL3

rsync -a -u -v -L /mnt/user/appdata/privkey.pem /mnt/user/appdata/docker-diag-tools/npm-21/privkey.pem
rsync -a -u -v -L /mnt/user/appdata/cert.pem /mnt/user/appdata/docker-diag-tools/npm-21/cert.pem
rsync -a -u -v -L /mnt/user/appdata/chain.pem /mnt/user/appdata/docker-diag-tools/npm-21/chain.pem

docker exec docker-diag-tools /bin/sh -c "
openssl pkcs12 -export -certpbe AES-256-CBC -keypbe AES-256-CBC -macalg SHA256 -out /workdir/npm-21/certificate.pfx \
    -passout pass: \
    -inkey /workdir/npm-21/privkey.pem  \
    -in /workdir/npm-21/cert.pem  \
    -certfile /workdir/npm-21/chain.pem
"




rsync -a -u -v -L /mnt/user/appdata/docker-diag-tools/npm-21/certificate.pfx /mnt/user/appdata/prowlarr/cert.pfx
chmod 666 /mnt/user/appdata/prowlarr/cert.pfx
