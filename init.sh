#!/usr/bin/env bash

CONTAINER_DIR=$(dirname ${BASH_SOURCE[0]})
TRY_PREFIX="⏳ "
DONE_PROMPT="   🍺  done."

set -e

# Initialize Common Files
echo "${TRY_PREFIX} Initializing Common Files..."
[ -f "${CONTAINER_DIR}/common/localtime" ] || cp /etc/localtime "${CONTAINER_DIR}/common"
[ -d "${CONTAINER_DIR}/common/tmp" ] || mkdir -p "${CONTAINER_DIR}/common/tmp"
echo "${DONE_PROMPT}"
echo ""

# Pull Images
echo "${TRY_PREFIX} Pulling Docker Images..."
IMAGES='genee/gini-dev:alpine genee/redis genee/mariadb genee/nginx genee/node'
for IMAGE in $IMAGES; do
    docker pull "${IMAGE}"
done
echo "${DONE_PROMPT}"
echo ""

# Initialize MariaDB
echo "${TRY_PREFIX} Initializing MariaDB..."
docker volume inspect mariadb > /dev/null 2>&1 && MARIADB_EXISTS=1 || MARIADB_EXISTS=0
if [ $MARIADB_EXISTS == 0 ]; then
    docker volume create mariadb
    docker run --rm -t -v mariadb:/var/lib/mysql genee/mariadb install
fi
unset MARIADB_EXISTS
echo "${DONE_PROMPT}"
echo ""

