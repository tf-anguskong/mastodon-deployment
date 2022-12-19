#!/bin/bash
# Make sure you have your Linode API Token saved as $TOKEN env variable
# Get current Public IP Address
publicIP=$(curl ifconfig.me)
domainID="<domain id>" # update with Linode Domain ID
recordID="<record id>" # update with Linode Record ID

# Get Linode IP Address
linodeIP=$(dig test.domain.com +short @8.8.8.8) #this will return the IP of the domain you want to test using Google DNS to resolve

if [[ "$publicIP" != "$linodeIP" ]]
then
    curl -H "Content-Type: application/json" \
    -H "Authorization: Bearer $TOKEN" \
    -X PUT --data-binary '{
      "type": "A",
      "target": "'"$publicIP"'"
    }'  https://api.linode.com/v4/domains/$domainID/records/$recordID
else
        exit
fi

# Linode API DNS Documentation - https://www.linode.com/docs/api/domains/
