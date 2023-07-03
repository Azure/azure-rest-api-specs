FROM mcr.microsoft.com/mirror/docker/library/ubuntu:22.04

RUN apt-get -y update &&  apt upgrade -y && apt install curl -y
RUN apt-get -y install git

# install node and npm
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt -y install nodejs
RUN npm install -g npm@9.5.0

# install oav tool
RUN npm install -g oav@latest

# install powershell
RUN apt-get update && apt-get install -y wget
RUN wget -q https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update
RUN apt-get install -y powershell

ENTRYPOINT ["/bin/bash"]