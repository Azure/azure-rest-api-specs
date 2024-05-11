FROM mcr.microsoft.com/mirror/docker/library/ubuntu:22.04

WORKDIR /workspaces/azure-rest-api-specs

RUN apt-get -y update \
 && apt-get upgrade -y \
 && apt-get install -y \
    curl \
    wget \
    git

RUN wget -q https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update -y
RUN npm install -g oav@latest

ENTRYPOINT ["/bin/bash"]
