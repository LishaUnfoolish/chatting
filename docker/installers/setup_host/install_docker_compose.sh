#!/usr/bin/env bash
set -e
BOLD='\033[1m'
RED='\033[0;31m'
GREEN='\033[32m'
WHITE='\033[34m'
YELLOW='\033[33m'
NO_COLOR='\033[0m'

function install_docker_x86() {

  sudo apt-get update
  sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y

  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io -y
  set +e
  sudo groupadd docker
  sudo gpasswd -a "$USER" docker
  sudo service docker restart
  echo -e "\n${YELLOW}Please exit this docker group after newgrp \nInput:"exit" in this terminal${NO_COLOR}"
  newgrp - docker
  sudo service docker restart
  set -e
}

function install_docker_compose(){
  sudo curl -L "https://github.com/docker/compose/releases/download/2.17.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

if ! command -v docker; then
  install_docker_x86
fi
if ! command -v docker-compose;then
  install_docker_compose
fi