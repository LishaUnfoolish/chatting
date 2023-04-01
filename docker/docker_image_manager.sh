#!/usr/bin/env bash
BOLD='\033[1m'
RED='\033[0;31m'
GREEN='\033[32m'
WHITE='\033[34m'
YELLOW='\033[33m'
NONE='\033[0m'

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../" && pwd -P)"
source ${ROOT_DIR}/docker/docker_common.sh

function info() {
  echo -e "[${WHITE}${BOLD}INFO${NONE}] $*"
}
function error() {
  echo >&2 -e "[${RED}ERROR${NONE}] $*"
}
function ok() {
  echo -e "[${GREEN}${BOLD} OK ${NONE}] $*"
}

function print_usage() {
  echo -e "\n${RED}Usage${NONE}:
  .${BOLD}/docker_image_manager.sh${NONE} [OPTION]"

  echo -e "\n${RED}Options${NONE}:
  ${BLUE}start_service${NONE}: Start all services in containers.
  ${BLUE}stop_containers${NONE}: Stop all containers.
  ${BLUE}into_container${NONE}: Into ${PROJECT_NAME} containers.
  ${BLUE}build_image${NONE}: Build containers.
  ${BLUE}push_image${NONE}: Build and push containers to harbo.
  ${BLUE}debug_start${NONE}: start debug mode.
  "
}

function build_image() {
  set -e
  docker build -f ${ROOT_DIR}/docker/Dockerfile -t ${PROJECT_NAME}:test .
  if [ $? -ne 0 ]; then
    error "Failed to build base docker image"
    exit 1
  fi
}

function push_image() {
  set -e
  build_image
  if [ $? -ne 0 ]; then
    error "Failed to push docker image"
    exit 1
  fi
  docker tag ${PROJECT_NAME}:test ${DOCKER_IMAGE}
  if [ $? -ne 0 ]; then
    error "Failed to docker tag."
    exit 2
  fi
  docker push "${DOCKER_IMAGE}"
  if [ $? -ne 0 ]; then
    error "Failed to push docker image"
    exit 3
  fi
  ok "Successfully built and pushed to ${DOCKER_IMAGE}"
}

function into_container() {
  WORKDIR=/${PROJECT_NAME}
  docker-compose \
    -f ${ROOT_DIR}/docker/docker-compose.yml \
    exec --user $USER --workdir ${WORKDIR} ${MAIN_SERVICE_NAME} /bin/bash
}

function start_service() {
  stop_containers
  cd ${ROOT_DIR} &&
    docker-compose -f ${ROOT_DIR}/docker/docker-compose.yml \
      up --detach --remove-orphans --force-recreate --renew-anon-volumes
}

function stop_containers() {
  cd ${ROOT_DIR} &&
    docker-compose \
      -f ${ROOT_DIR}/docker/docker-compose.yml \
      down --remove-orphans
}
function debug_start() {
  stop_containers
  cd ${ROOT_DIR} &&
    docker-compose -f ${ROOT_DIR}/docker/docker-compose.yml run -p ${WEB_SERVER_PORT} ${MAIN_SERVICE_NAME}
}

function main() {
  local cmd=$1
  shift
  case $cmd in
  start_service)
    start_service "$@"
    ;;
  stop_containers)
    stop_containers "$@"
    ;;
  into_container)
    into_container "$@"
    ;;
  build_image)
    build_image "$@"
    ;;
  push_image)
    push_image "$@"
    ;;
  debug_start)
    debug_start "$@"
    ;;
  *)
    print_usage
    ;;
  esac
}
main "$@"
