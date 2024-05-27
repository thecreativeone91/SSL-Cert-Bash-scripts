#!/bin/bash
##Scrypted

awk 'BEGIN{RS="\n";ORS="\r\n"}1' /mnt/user/appdata/privkey.pem > /mnt/user/appdata/privkeyformated.txt
awk 'BEGIN{RS="\n";ORS="\r\n"}1' /mnt/user/appdata/fullchain.pem > /mnt/user/appdata/fullchainformated.txt
rsync -a -u -v -L /mnt/user/appdata/ssl.json.template /mnt/user/appdata/ssl.json


# Define paths to JSON file and text file
json_file="/mnt/user/appdata/ssl.json"
text_file="/mnt/user/appdata/privkeyformated.txt"
text_file2="/mnt/user/appdata/fullchainformated.txt"

# Read text from text file
text_content=$(<"$text_file")
text_content2=$(<"$text_file2")

# Update JSON file using jq
jq --arg content "$text_content" '.key = $content' "$json_file" > tmp.json && mv tmp.json "$json_file"
jq --arg content "$text_content2" '.cert = $content' "$json_file" > tmp.json && mv tmp.json "$json_file"


##Copy to Scrypted
rsync -a -u -v -L /mnt/user/appdata/ssl.json /mnt/user/appdata/scrypted/ssl.json
chmod 666 /mnt/user/appdata/scrypted/ssl.json
