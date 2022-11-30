#!/usr/bin/env bash

ENV_DIR=$(dirname ${BASH_SOURCE[0]})
ENV_DIR=$(cd $ENV_DIR && pwd)
TRY_PREFIX="⏳ "
DONE_PROMPT="🍺  done."

set -e

# Initialize Common Files and Directories
echo "${TRY_PREFIX} Initializing Common Files..."
[ -f "${ENV_DIR}/common/localtime" ] || cp /etc/localtime "${ENV_DIR}/common"
[ -d "${ENV_DIR}/common/tmp" ] || mkdir -p "${ENV_DIR}/common/tmp"
echo "   finished."

# Initialize Some Files for Container 
echo "${TRY_PREFIX} Initializing Some Files for Container..."
[ -d "${ENV_DIR}/.ssh" ] || mkdir -p "${ENV_DIR}/.ssh"
echo "   finished."

# Initialize Network
echo "${TRY_PREFIX} Initializing dev network..."
docker network inspect dev > /dev/null 2>&1 && DEV_EXISTS=1 || DEV_EXISTS=0
if [ $DEV_EXISTS == 0 ]; then
    docker network create dev
fi
unset DEV_EXISTS
echo "   finished."

# Initialize Git Config
if [ ! -f "${ENV_DIR}/.gitconfig" ]; then
    read -p "Your git user name: " GIT_USER_NAME && \
    read -p "         and email: " GIT_USER_EMAIL && \
    GIT_USER_NAME=${GIT_USER_NAME:='Nobody'} && \
    GIT_USER_EMAIL=${GIT_USER_EMAIL:='nobody@geneegroup.com'} && \
    printf "[user]\nname=%s\nemail=%s\n[color]\nui=auto\n" "$GIT_USER_NAME" "$GIT_USER_EMAIL" > "${ENV_DIR}/.gitconfig"
fi

if [ ! -f "${ENV_DIR}/.git-credentials" ]; then
    touch "${ENV_DIR}/.git-credentials"
fi