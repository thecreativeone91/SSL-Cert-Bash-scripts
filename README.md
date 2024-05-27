**SSL Certificate Update Scripts
**



This repository contains simple bash scripts designed to update SSL certificates, particularly those renewed via Let's Encrypt certbot, and apply them to internal hosts. The automation process can be streamlined using Nginx Proxy Manager Docker containers to update the certificates via Cloudflare (or other DNS) API verification.

These scripts are specifically for services that require more than just copying files.



Available Scripts

aspeed.sh
For updating SSL certificates on Aspeed IPMI (Asrock Rack). This script may also work with other systems such as Supermicro.

mikrotik-routerOS.sh
Used with Mikrotik CRS305 (Should work on any RouterOS based) switches, which are utilized for remote Starlink over single-mode fiber connections, remote cable modem over single-mode fiber, and a high availability cluster of Unifi Dream Machine SEs to split internet connections. Requires SSH public key authentication to be set up.

scrypted.sh
For updating SSL certificates used with Scrypted for HomeKit cameras from Unifi. Certificates need to be in a JSON file format. This script requires the use of the ssl.json.template file.

unraid.sh
Combines certificates into a single file and restarts Unraid web services.


------------
Media Automation Scripts

plex.sh
Updates SSL certificates for Plex Media Server. PFX files may not work properly with Plex without the additional commands.

prowlarr.sh
For updating SSL certificates on Prowlarr. PFX files may not work properly with Plex without the additional commands.

radarr.sh
For updating SSL certificates on Radarr. PFX files may not work properly with Plex without the additional commands.

sonarr.sh
For updating SSL certificates on Sonarr. PFX files may not work properly with Plex without the additional commands.



These scripts are intended to simplify the process of updating and applying SSL certificates across various services. 
