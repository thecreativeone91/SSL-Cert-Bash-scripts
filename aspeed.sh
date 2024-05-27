#!/bin/bash
####Asrock Rack IPMI may be useful for other aspeed based IPMIs

### Remove -v to remove verbose output from CURL commands after deployment
## Replace URL with ipmi address

##Get Authentication
curl -v -k -c cookies.txt  'https://url' \
   -X POST \
   -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'Accept-Language: en-US,en;q=0.5' \
   -H 'Accept-Encoding: gzip, deflate, br' \
   -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
   -H 'X-CSRFTOKEN: null' \
   -H 'X-Requested-With: XMLHttpRequest' \
   -H 'Origin: https://url' \
   -H 'Connection: keep-alive' \
   -H 'Sec-Fetch-Dest: empty' \
   -H 'Sec-Fetch-Mode: cors' \
   -H 'Sec-Fetch-Site: same-origin' \
   -H 'Pragma: no-cache' \
   -H 'Cache-Control: no-cache' \
   --data-raw 'username=ssl&password=passwprd1' \
   | grep -o '"CSRFToken": *"[^"]*"' | awk -F'"' '{print $4}' > csrf.txt


###Get Certs
## For information purposes only
#curl -v -k -L -b cookies.txt 'https://url' \
# -X GET \
#-H "X-CSRFTOKEN: $(cat csrf.txt)" \
# -H 'Accept: application/json, text/javascript, */*; q=0.01' \
# -H 'Accept-Language: en-US,en;q=0.5' \
# -H 'Accept-Encoding: gzip, deflate, br' \
# -H 'X-Requested-With: XMLHttpRequest' \
# -H 'Content-Type: multipart/form-data; boundary=---------------------------301740235028817083163214535904' \
# -H 'Origin: https://url' \
# -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0' \
# -H 'Pragma: no-cache' \
# -H 'Cache-Control: no-cache' \
# -H 'Connection: keep-alive' \
# -H 'Sec-Fetch-Dest: empty' \
# -H 'Sec-Fetch-Mode: cors' \
# -H 'Sec-Fetch-Site: same-origin' \
# -H 'DNT: 1' \
# -H 'Sec-GPC: 1'

###Upload our Certs

curl -v -k -L -b cookies.txt "https://url" \
-X POST \
-H "X-CSRFTOKEN: $(cat csrf.txt)" \
-H 'Content-Type: multipart/form-data' \
--form "new_certificate=@/mnt/user/appdata/letsencrypt/live/npm-12/fullchain.pem" \
--form "new_private_key=@/mnt/user/appdata/letsencrypt/live/npm-12/privkey.pem"
