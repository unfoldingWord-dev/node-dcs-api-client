#!#/bin/env bash

set -x
set -e

version=$(curl -H 'Content-type: application/json' https://git.door43.org/api/v1/version | jq -r '.version'| cut -f1 -d"+")

curl -H 'Content-type: application/json' -X POST -d "{\"options\": {\"npmName\": \"dcs_api_client\", \"npmVersion\": \"$version\", \"supportsES6\": \"true\"}, \"swaggerUrl\": \"https://git.door43.org/swagger.v1.json\"}" https://generator.swagger.io/api/gen/clients/typescript-node | curl $(jq -r '.link') -o client.zip

unzip client.zip

rsync -P -rvzc --delete --exclude-from="update_client_exclude_list.txt" typescript-node-client/ ./

rm -rf typescript-node-client
