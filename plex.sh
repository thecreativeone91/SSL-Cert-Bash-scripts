#!/bin/bash
##Requires docker-diag-tools
##Plex
##Copy to Docker for OpenSSL3
rsync -a -u -v -L /mnt/user/privkey.pem /mnt/user/appdata/docker-diag-tools/npm-9/privkey.pem
rsync -a -u -v -L /mnt/user/appdata/cert.pem /mnt/user/appdata/docker-diag-tools/npm-9/cert.pem
rsync -a -u -v -L /mnt/user/appdata/chain.pem /mnt/user/appdata/docker-diag-tools/npm-9/chain.pem

docker exec docker-diag-tools /bin/sh -c "
openssl pkcs12 -export -out /workdir/npm-9/certificate.pfx \
    -passout pass: \
    -inkey /workdir/npm-9/privkey.pem  \
    -in /workdir/npm-9/cert.pem  \
    -certfile /workdir/npm-9/chain.pem
"

##Copy PFX to Plex       
rsync -a -u -v -L /mnt/user/appdata/docker-diag-tools/npm-9/certificate.pfx /mnt/user/appdata/plexpass/certificate.pfx
chmod 666 /mnt/user/appdata/plexpass/certificate.pfx
