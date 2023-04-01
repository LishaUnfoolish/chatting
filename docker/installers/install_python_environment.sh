#!/usr/bin/env bash
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../" && pwd -P)"

function install_package() {
  echo "Start install python packages..."
  REQUIREMENTS_FILE="${ROOT_DIR}/docker/installers/requirements.txt"
  pip3 install -r ${REQUIREMENTS_FILE}
}

function print_usage() {
  RED='\033[0;31m'
  BLUE='\033[0;34m'
  BOLD='\033[1m'
  NONE='\033[0m'

  echo -e "\n${RED}Usage${NONE}:
  .${BOLD}/install_python_environment.sh${NONE} [OPTION]"

  echo -e "\n${RED}Options${NONE}:
  ${BLUE}install_env${NONE}: Install the Python runtime environment.
  "
}

function main() {
  local cmd=$1
  shift
  case $cmd in
  install_env)
    install_package "$@"
    ;;
  *)
    print_usage
    ;;
  esac

}

main "$@"
