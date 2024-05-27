#!/bin/bash

##Unraid 
cat /mnt/user/appdata/fullchain.pem /mnt/user/appdata/privkey.pem > /mnt/user/appdata/unraid.pem

rsync -a -u -v -L /mnt/user/appdata/unraid.pem /boot/config/ssl/certs/SERVERNAME_unraid_bundle.pem
## Restart Webgui
/etc/rc.d/rc.nginx stop
sleep 10
/etc/rc.d/rc.nginx start
