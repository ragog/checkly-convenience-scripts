#!/bin/bash
# Creates n browser checks with a given label.
# usage: ./create-browser-check <API_KEY> <label> <number_of_checks>

for ((i=1;i<=$3;i++)); 
do
  echo $i
  curl -X POST https://api.checklyhq.com/v1/checks \
    -H "Content-Type: application/json" \
    -H "Accept: application/json" \
    -H "Authorization: Bearer $1" -d '{
  "name": "'"$2"'-'"$i"'",
  "checkType": "BROWSER",
  "frequency": 5,
  "activated": true,
  "muted": false,
  "doubleCheck": true,
  "sslCheck": false,
  "shouldFail": false,
  "locations": [
    "us-east-1"
  ],
  "script": "const assert = require(\"chai\").assert;const puppeteer = require(\"puppeteer\");const browser = await puppeteer.launch();const page =await browser.newPage();await page.goto(\"https://google.com/\");const title = await page.title();assert.equal(title, \"Google\"); await new Promise(resolve => setTimeout(resolve, '"$1"'000));.close();",
  "alertSettings": {
    "escalationType": "RUN_BASED",
    "runBasedEscalation": {
      "failedRunThreshold": 1
    },
    "timeBasedEscalation": {
      "minutesFailingThreshold": 5
    },
    "reminders": {
      "amount": 0,
      "interval": 5
    },
    "sslCertificates": {
      "enabled": true,
      "alertThreshold": 30
    }
  },
  "useGlobalAlertSettings": true,
  "degradedResponseTime": 10000,
  "maxResponseTime": 20000
}'
done