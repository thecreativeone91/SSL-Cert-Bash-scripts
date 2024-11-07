#!/bin/bash
# Cyberpower RMCARD205 Card Certificate Upload

##NOTE: the RMC only seems to support keys in the RSA 2048 varriant
# Remove -v to remove verbose output from CURL commands after deployment
# Replace URL with UPS Address

#Combine Certs
privkey="/mnt/user/appdata/Nginx-Proxy-Manager-Official2/letsencrypt/live/npm-1/privkey.pem"
fullchain="/mnt/user/appdata/Nginx-Proxy-Manager-Official2/letsencrypt/live/npm-1/fullchain.pem"
output="/mnt/user/appdata/docker-diag-tools/npm-52/RMC.crt"

# Combine the private key and full chain into the output file
cat "$privkey" "$fullchain" > "$output"

# Remove trailing carriage returns and empty lines at the end of the output file
sed -i 's/\r$//' "$output"
sed -i '${/^$/d}' "$output"

# Confirm the result
if [ -f "$output" ]; then
    echo "Certificate successfully combined into $output"
else
    echo "Failed to create the combined certificate"
fi

# Get Authentication
curl -v -k -c --insecure upscookies.txt 'https://URL' \
   -X POST \
   -H 'Accept: application/json, text/javascript, */*; q=0.01' \
   -H 'Accept-Language: en-US,en;q=0.5' \
   -H 'Accept-Encoding: gzip, deflate, br' \
   -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
   -H 'X-CSRFTOKEN: null' \
   -H 'X-Requested-With: XMLHttpRequest' \
   -H 'Origin: https://URL' \
   -H 'Connection: keep-alive' \
   -H 'Sec-Fetch-Dest: empty' \
   -H 'Sec-Fetch-Mode: cors' \
   -H 'Sec-Fetch-Site: same-origin' \
   -H 'Pragma: no-cache' \
   -H 'Cache-Control: no-cache' \
   --data-raw 'username=username&password=Password1' \
   | grep -o '"CSRFToken": *"[^"]*"' | awk -F'"' '{print $4}' > upscsrf.txt



# Upload certificate
curl -v -k -L -b upscookies.txt "https://URL/cert_modify.cgi" \
   -X POST \
   -H "X-CSRFTOKEN: $(cat upscsrf.txt)" \
   -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:130.0) Gecko/20100101 Firefox/130.0' \
   -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/png,image/svg+xml,*/*;q=0.8' \
   -H 'Accept-Language: en-US,en;q=0.5' \
   -H 'Accept-Encoding: gzip, deflate' \
   -H 'Content-Type: multipart/form-data' \
   -H 'Origin: https://URL \
   -H 'Connection: keep-alive' \
   -H 'Referer: https://URL/cert_modify.html' \
   -H 'Upgrade-Insecure-Requests: 1' \
   -H 'Priority: u=0, i' \
   -H 'Pragma: no-cache' \
   -H 'Cache-Control: no-cache' \
   --form "upfile=@/mnt/user/appdata/docker-diag-tools/npm-52/RMC.crt"

# Logout
curl -v -k 'https://URL/logout.html' \
   -H "X-CSRFTOKEN: $(cat upscsrf.txt)" \
   -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:130.0) Gecko/20100101 Firefox/130.0' \
   -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/png,image/svg+xml,*/*;q=0.8' \
   -H 'Accept-Language: en-US,en;q=0.5' \
   -H 'Accept-Encoding: gzip, deflate' \
   -H 'Connection: keep-alive' \
   -H 'Referer: https://URL/cert_modify.cgi' \
   -H 'Upgrade-Insecure-Requests: 1' \
   -H 'Priority: u=0, i' \
   -H 'Pragma: no-cache' \
   -H 'Cache-Control: no-cache'
