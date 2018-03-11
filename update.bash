#!/usr/bin/env bash

CONTAINER_DIR=$(dirname ${BASH_SOURCE[0]})
CONTAINER_DIR=$(cd $CONTAINER_DIR && pwd)
TRY_PREFIX="⏳ "
DONE_PROMPT="🍺  done."

set -e

# Pull Images
# echo "${TRY_PREFIX} Pulling Docker Images..."
# IMAGES='genee/gini-dev:alpine genee/redis genee/mariadb genee/nginx node:alpine'
# for IMAGE in $IMAGES; do
#     echo "   pulling ${IMAGE}..."
#     docker pull "${IMAGE}" | sed 's/^/     /'
# done
# echo "${DONE_PROMPT}"
# echo ""

# Update containers
echo "${TRY_PREFIX} Updating Docker Images..."
CONTAINERS='gini redis mariadb nginx node'
for CONTAINER in $CONTAINERS; do
    echo "   update ${CONTAINER_DIR}/${CONTAINER}..."
    cd "${CONTAINER_DIR}/${CONTAINER}" && \
        docker-compose down && docker-compose up -d
done
echo "${DONE_PROMPT}"
echo ""

