#!/usr/bin/env bash

STACKS_DIR=$(dirname ${BASH_SOURCE[0]})
STACKS_DIR=$(cd $STACKS_DIR && pwd)
TRY_PREFIX="⏳ "
DONE_PROMPT="🍺  done."

set -e

# Initialize Common Files
echo "${TRY_PREFIX} Initializing Common Files..."
[ -f "${STACKS_DIR}/common/localtime" ] || cp /etc/localtime "${STACKS_DIR}/common"
[ -d "${STACKS_DIR}/common/tmp" ] || mkdir -p "${STACKS_DIR}/common/tmp"
echo "   finished."

# Pull Images
echo "${TRY_PREFIX} Pulling Docker Images..."
IMAGES='genee/gini-dev:alpine genee/redis genee/mariadb genee/nginx node:alpine'
for IMAGE in $IMAGES; do
    docker pull "${IMAGE}"
done
echo "   finished."

# Initialize MariaDB
echo "${TRY_PREFIX} Initializing MariaDB..."
docker volume inspect mariadb > /dev/null 2>&1 && MARIADB_EXISTS=1 || MARIADB_EXISTS=0
if [ $MARIADB_EXISTS == 0 ]; then
    docker volume create mariadb
    docker run --rm -t -v mariadb:/var/lib/mysql genee/mariadb install
fi
unset MARIADB_EXISTS
echo "   finished."

# Initialize Git Config
if [ ! -f "${STACKS_DIR}/.gitconfig" ]; then
    read -p "Your git user name: " GIT_USER_NAME && \
    read -p "         and email: " GIT_USER_EMAIL && \
    GIT_USER_NAME=${GIT_USER_NAME:='Nobody'} && \
    GIT_USER_EMAIL=${GIT_USER_EMAIL:='nobody@geneegroup.com'} && \
    printf "[user]\nname=%s\nemail=%s\n[color]\nui=auto\n" "$GIT_USER_NAME" "$GIT_USER_EMAIL" > "${STACKS_DIR}/web/.gitconfig"
fi

if [ ! -f "${STACKS_DIR}/.git-credentials" ]; then
    touch "${STACKS_DIR}/.git-credentials"
fi

echo ""
echo "Please add following line to ~/.profile if you want to access node/npm/gini/composer command from the host."
echo ""
echo "  source ${STACKS_DIR}/.profile"
echo ""

echo "${DONE_PROMPT}"
echo ""
