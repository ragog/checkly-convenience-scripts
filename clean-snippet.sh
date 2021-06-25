#!/bin/bash
# Reads and deletes all snippets, provided an account's API key
echo 'Deleting snippets...'
curl -s -X GET 'https://api.checklyhq.com/v1/snippets?limit=100' \
 -H 'Accept: application/json' \
 -H "Authorization: Bearer $1" | grep -Ewo '[[:xdigit:]]{3,6}' |
while IFS= read -r guid
do
    echo "Deleting snippet with ID: $guid"
    curl -s -X DELETE https://api.checklyhq.com/v1/snippets/$guid \
  -H 'Accept: application/json' \
  -H "Authorization: Bearer $1"
done