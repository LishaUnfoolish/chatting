#!/usr/bin/env bash
wget https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
sudo dpkg -i nvidia-docker_1.0.1-1_amd64.deb
sudo apt-get install -f
rm nvidia-docker_1.0.1-1_amd64.deb

