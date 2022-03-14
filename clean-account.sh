#!/bin/bash
# Reads and deletes all groups, checks, alert channels and snippets on an account, provided an account's API key
# usage: ./clean-account.sh <API_KEY>
echo 'Deleting groups...'
curl -s -X GET 'https://api.checklyhq.com/v1/check-groups?limit=100' \
 -H 'Accept: application/json' \
 -H "Authorization: Bearer $1" | grep -Ewo '[[:xdigit:]]{6,7}' |
while IFS= read -r guid
do
  echo "Deleting group with ID: $guid"
  curl -s -X DELETE https://api.checklyhq.com/v1/check-groups/$guid \
  -H 'Accept: application/json' \
  -H "Authorization: Bearer $1" &
done

echo 'Deleting checks...'
curl -s -X GET 'https://api.checklyhq.com/v1/checks?limit=100' \
 -H 'Accept: application/json' \
 -H "Authorization: Bearer $1" | grep -Ewo '[[:xdigit:]]{8}(-[[:xdigit:]]{4}){3}-[[:xdigit:]]{12}' |
while IFS= read -r guid
do
  echo "Deleting check with ID: $guid"
  curl -s -X DELETE https://api.checklyhq.com/v1/checks/$guid \
  -H 'Accept: application/json' \
  -H "Authorization: Bearer $1" &
done

echo 'Deleting alert channels...'
curl -s -X GET 'https://api.checklyhq.com/v1/alert-channels?limit=100' \
 -H 'Accept: application/json' \
 -H "Authorization: Bearer $1" | grep -Ewo '[[:xdigit:]]{5,6}' |
while IFS= read -r guid
do
    echo "Deleting alert channel with ID: $guid"
    curl -s -X DELETE https://api.checklyhq.com/v1/alert-channels/$guid \
  -H 'Accept: application/json' \
  -H "Authorization: Bearer $1" &
done

echo 'Deleting snippets...'
curl -s -X GET 'https://api.checklyhq.com/v1/snippets?limit=100' \
 -H 'Accept: application/json' \
 -H "Authorization: Bearer $1" | grep -Ewo '[[:xdigit:]]{3,6}' |
while IFS= read -r guid
do
    echo "Deleting snippet with ID: $guid"
    curl -s -X DELETE https://api.checklyhq.com/v1/snippets/$guid \
  -H 'Accept: application/json' \
  -H "Authorization: Bearer $1" &
done