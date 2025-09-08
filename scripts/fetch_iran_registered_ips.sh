#!/bin/bash

curl -s 'https://stat.ripe.net/data/country-resource-list/data.json?resource=IR' -o data.json

if [ $? -ne 0 ]; then
  echo "Error receiving data :("
  exit 1
fi

mkdir -p output

jq -r '.data.resources.ipv4[]' data.json > output/iran_registered_ipv4.txt

jq -r '.data.resources.ipv6[]' data.json > output/iran_registered_ipv6.txt

echo "The operation was successful. :)"
