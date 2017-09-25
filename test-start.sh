#!/bin/bash

set -e

main() {
  env \
    DEBUG=* \
    PORT=3010 \
    MESHBLU_SERVER="localhost" \
    MESHBLU_HOSTNAME="localhost" \
    MESHBLU_HOST="localhost" \
    MESHBLU_PORT=3000 \
    MESHBLU_PROTOCOL="http" \
    SERVICE_URL="http://localhost:3010" \
    node command.js "$@"
}

main "$@"

#MESHBLU_UUID
#MESHBLU_TOKEN
#MESHBLU_PRIVATE_KEY

