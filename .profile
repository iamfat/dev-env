#!/usr/bin/env bash

eval "$(fasd --init auto)"

GENEE_DATA_DIR=${GENEE_DATA_DIR:="/Volumes/Codes/data/"}
GENEE_NODE_CONTAINER=${GENEE_NODE_CONTAINER:="node"}
GENEE_GINI_CONTAINER=${GENEE_GINI_CONTAINER:="gini"}

function __docker_exec_cmd() {
  local params=($@)
  local service=${params[0]}
  local container_id=$(docker container ps -f 'name='$service -q)
  if [ -z "$container_id" ]; then
    echo "Container \"*$service*\" was not found!"
    return 127
  else
    shift
    docker exec -it $container_id "$@"
  fi
}

function __docker_node_cmd() {
  local VOLUME_PATH=${PWD#$GENEE_DATA_DIR}
  local COMMAND="$@"
  if [[ $VOLUME_PATH == $PWD ]]; then
    VOLUME_PATH='node'
  fi
  __docker_exec_cmd node sh -lc "cd /data/${VOLUME_PATH} && ${COMMAND}"
}

function __docker_gini_cmd() {
  local VOLUME_PATH=${PWD#$GENEE_DATA_DIR}
  local COMMAND="$@"
  if [[ $VOLUME_PATH == $PWD ]]; then
    VOLUME_PATH='gini-modules'
  fi
  __docker_exec_cmd gini sh -lc "cd /data/${VOLUME_PATH} && ${COMMAND}"
}

# $HOME/Codes/data/node/xxxx
alias de='__docker_exec_cmd'
alias dn='__docker_node_cmd'
alias dg='__docker_gini_cmd'