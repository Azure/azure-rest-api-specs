FROM mcr.microsoft.com/mirror/docker/library/ubuntu:22.04

WORKDIR /workspaces/azure-rest-api-specs

RUN apt-get -y update \
 && apt-get upgrade -y \
 && apt-get install -y \
    curl \
    wget \
    git

RUN npm install -g oav@latest

ENTRYPOINT ["/bin/bash"]