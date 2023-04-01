#!/usr/bin/env bash
export PROJECT_NAME="xchatgpt"
export DOCKER_IMAGE="lixiaoxmm/${PROJECT_NAME}:v0.0.7"
export USER_ID=$(id -u)
export GRP=$(id -g -n)
export GRP_ID=$(id -g)
export DOCKER_IMAGE=${DOCKER_IMAGE}
export ROOT_DIR=${ROOT_DIR}
export USER=${USER}
export DB_USER="USER"
export DB_PASSWORD="PW"
export DB_NAME="DB"
export WEB_SERVER_PORT="3000:3000"
export PROJECT_NAME=${PROJECT_NAME}
export MAIN_SERVICE_NAME="main_server"
echo "${PROJECT_NAME}"
