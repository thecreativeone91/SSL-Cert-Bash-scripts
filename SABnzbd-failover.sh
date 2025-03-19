#!/bin/bash

# Configuration
SABNZBD_HOST="http://host:port"       # Replace with your SABnzbd host and port
API_KEY="APIKEY"                      # Replace with your actual API key

# Function to pause SABnzbd
pause_sabnzbd() {
    curl -s "$SABNZBD_HOST/sabnzbd/api?output=json&apikey=$API_KEY&mode=pause" > /dev/null
    echo "SABnzbd paused."
}

# Function to resume SABnzbd
resume_sabnzbd() {
    curl -s "$SABNZBD_HOST/sabnzbd/api?output=json&apikey=$API_KEY&mode=resume" > /dev/null
    echo "SABnzbd resumed."
}

# Check ISP from the DNSChecker website
isp=$(curl -s "https://dnschecker.org/what-is-my-isp.php")

# Check if the ISP contains the keyword
if echo "$isp" | grep -q "ISPNAME"; then
    echo "ISP matches"
    
    # Check if SABnzbd is paused using jq for accurate JSON parsing
    paused=$(curl -s "$SABNZBD_HOST/sabnzbd/api?output=json&apikey=$API_KEY&mode=queue" | jq -r '.queue.paused' | tr -d '\n')
    echo "Paused status: $paused"  # Debugging line

    if [ "$paused" == "true" ]; then
        resume_sabnzbd
    else
        echo "SABnzbd is already running."
    fi
else
    echo "ISP does not match. Pausing SABnzbd."
    pause_sabnzbd
fi
