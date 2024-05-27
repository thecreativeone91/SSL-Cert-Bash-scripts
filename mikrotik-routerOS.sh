#!/bin/bash

##Requires user setup on mikrotik with public key auth. Must login at least once via ssh to add to authorized keys before running script. 

DOMAIN=fiber-converter-DNS.DNS
CERTPATH=/mnt/user/appdata/npm-37
CERT=fullchain.pem
KEY=privkey.pem
ROUTER=fiber-converter-DNS.DNS
ROUTER_USER=unraid


scp -q -i ~/.ssh/id_rsa.key $CERTPATH/$CERT $CERTPATH/$KEY $ROUTER_USER@$ROUTER:/
if [ $? -ne 0 ]; then
  echo "Unable to upload cert/key files"
  exit 1
fi

ssh -i ~/.ssh/id_rsa.key $ROUTER_USER@$ROUTER "/certificate remove [/certificate find where name~\"${CERT}_*\"]"
if [ $? -ne 0 ]; then
  echo "Unable to remove old certificate"
  exit 1
fi

ssh -i ~/.ssh/id_rsa.key $ROUTER_USER@$ROUTER "/certificate import file-name=${CERT} passphrase=\"\" ; /certificate import file-name=${KEY} passphrase=\"\""
if [ $? -ne 0 ]; then
  echo "Unable to install new certificate"
  exit 1
fi


ssh -i ~/.ssh/id_rsa.key $ROUTER_USER@$ROUTER "/ip service set www-ssl certificate=[/certificate find where common-name=\"${DOMAIN}\"]"
if [ $? -ne 0 ]; then
  echo "Unable to assign new certificate to www-ssl"
  exit 1
fi
