# SSL Certificate Update Scripts


These scripts are intended to simplify the process of updating and applying SSL certificates across various services. 


This repository contains simple bash scripts designed to update SSL certificates, particularly those renewed via Let's Encrypt certbot, and apply them to internal hosts. The automation process can be streamlined using Nginx Proxy Manager Docker containers to update the certificates via Cloudflare (or other DNS) API verification; if you wish to have a GUI interface.

These scripts are specifically for services that require more than just copying files.



# Available Scripts

[/ComfyUI/main.py](/ComfyUI/main.py) also requires [/ComfyUI/override_server.py](/ComfyUI/override_server.py) and is using for adding SSL to ComfyUI (stadalone or Docker Containers such as comfyui-nvidia-docker) for Stable Diffusion AI Image generation, can easily be implmented with Certificate automation. Rename the existing main.py to main_http.py for the script to work. 

[cyberpower.sh](cyberpower.sh)
For updating SSL Certificates on CyberPower UPS's using the RMCARD205. Created for Firmware version 1.4.3

[aspeed.sh](aspeed.sh)
For updating SSL certificates on Aspeed IPMI (Asrock Rack). This script may also work with other systems such as Supermicro.

[mikrotik-routerOS.sh](mikrotik-routerOS.sh)
Used with Mikrotik CRS305 (Should work on any RouterOS based) switches, which are utilized for remote Starlink over single-mode fiber connections, remote cable modem over single-mode fiber, and a high availability cluster of Unifi Dream Machine SEs to split internet connections. Requires SSH public key authentication to be set up.

[scrypted.sh](scrypted.sh)
For updating SSL certificates used with Scrypted for HomeKit cameras from Unifi. Certificates need to be in a JSON file format. This script requires the use of the [ssl.json.template](ssl.json.template) file.

[unraid.sh](unraid.sh)
Combines certificates into a single file and restarts Unraid web services.



### Media Automation Scripts

These scripts requires [ccmpbll/docker-diag-tools](https://github.com/ccmpbll/docker-diag-tools). It can also easily be changed to work with another docker container with OpenSSL3 or locally installed OpenSSL3

[plex.sh](plex.sh)
Updates SSL certificates for Plex Media Server. PFX files may not work properly with Plex without the additional commands.

[prowlarr.sh](prowlarr.sh)
For updating SSL certificates on Prowlarr. PFX files may not work properly with Plex without the additional commands.

[radarr.sh](radarr.sh)
For updating SSL certificates on Radarr. PFX files may not work properly with Plex without the additional commands.

[sonarr.sh](sonarr.sh)
For updating SSL certificates on Sonarr. PFX files may not work properly with Plex without the additional commands.
