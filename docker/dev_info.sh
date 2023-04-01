#!/usr/bin/env bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd -P )"
source ${ROOT_DIR}/docker/docker_common.sh
xhost +local:root 1>/dev/null 2>&1
docker exec \
    -u $USER \
    -it chatgpt_$USER \
    /bin/bash
xhost -local:root 1>/dev/null 2>&1