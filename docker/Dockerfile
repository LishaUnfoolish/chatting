FROM lixiaoxmm/ubuntu22.10:original AS base

ENV LD_LIBRARY_PATH=/usr/local/lib
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

RUN apt-get update -yqq \
  && apt-get upgrade -yqq \
  && apt-get install -yqq --no-install-recommends \
  curl \
  wget \
  sudo \
  vim 


COPY docker/ /docker
RUN mkdir "/$(docker/docker_common.sh)"
RUN rm /docker -rf


RUN apt-get update && \
  apt-get install -y gnupg gnupg2 gnupg1 && \
  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && \
  apt-get install -y nodejs && \
  curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install -y yarn