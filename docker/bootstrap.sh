#!/usr/bin/env bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd -P )"
source ${ROOT_DIR}/docker/docker_common.sh
source /${PROJECT_NAME}/docker/docker_adduser.sh

# program execution blocking
tail -f /dev/null