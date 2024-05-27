Simple bash scripts for updating SSL Certs espcially those that are renewed via Let's Encrypt certbot to apply the ssl certs to internal host. Automation can be easily done using nginx proxy manager docker containers to just update the certs using Cloudflare (or other DNS) API verification.

Scripts are only covering services that are not a simple file copy. 

aspeed.sh - Aspeed IPMI (Asrook Rack) may be able to be used on others such as supermicro etc. 

mikrotik-routerOS.sh - Personally using these with Mikrotik CRS305's that are used for a remote Starlink over Single Mode Fiber connection. Remote Cable modem over Single Mode fiber and 2 used for a High Avilability Cluster of Unifi Dream Machine SEs to split the Internet connections. Requires ssh public key authentication to be setup. 

scrypted.sh - used for scrypted for homekit cameras from unifi. Certs need to be in a json file. Requires use of the ssl.json.template file. 

unraid.sh - simple script compbines certs to a single file and restarts unraid web services. 


--- Media Automation -- 

plex.sh - used with plex media server, pfx will fail to work properly with plex without some extra commands. 

prowlarr.sh

radarr.sh

sonarr.sh


