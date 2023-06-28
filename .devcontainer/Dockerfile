FROM mcr.microsoft.com/mirror/docker/library/ubuntu:22.04

RUN apt-get -y update &&  apt upgrade -y && apt install curl -y
RUN apt-get -y install git

# install node
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt -y install nodejs
RUN npm install -g npm@9.5.0

RUN npm install -g oav@latest

ENTRYPOINT ["/bin/bash"]