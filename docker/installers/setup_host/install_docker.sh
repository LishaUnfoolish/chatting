#!/usr/bin/env bash
function install_docker_x86() {
  sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get update
  sudo apt-get install -y docker-ce
  sudo groupadd docker
  sudo gpasswd -a "$USER" docker
  sudo usermod -aG docker $USER
  newgrp docker
}

function install_docker_arm() {
  sudo bash -c 'echo "deb [arch=arm64] https://download.docker.com/linux/ubuntu xenial edge" > /etc/apt/sources.list.d/docker.list'
  sudo apt-get update
  sudo apt-get install -y docker-ce
  sudo groupadd docker
  sudo gpasswd -a "$USER" docker
  newgrp docker
}

function install() {
MACHINE_ARCH=$(uname -m)
if [ "$MACHINE_ARCH" == 'x86_64' ]; then
  install_docker_x86
elif [ "$MACHINE_ARCH" == 'aarch64' ]; then
  install_docker_arm
else
  echo "Unknown machine architecture $MACHINE_ARCH"
  exit 1
fi
}

case $1 in
  install)
      install
      ;;
   uninstall)
      sudo apt-get remove docker docker-engine docker.io
      sudo apt-get purge docker-ce
      ;;
   *)
      install
      ;;
esac
