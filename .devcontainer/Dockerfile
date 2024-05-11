FROM mcr.microsoft.com/mirror/docker/library/ubuntu:22.04

WORKDIR /workspaces/azure-rest-api-specs

RUN apt-get -y update \
 && apt-get upgrade -y \
 && apt-get install -y \
    curl \
    wget \
    git

# install powershell
RUN wget -q https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
&& dpkg -i packages-microsoft-prod.deb \
&& apt-get update \
&& apt-get install -y powershell

# install node, npm, oav
RUN curl -sL https://deb.nodesource.com/setup_22.x | bash - \
 && apt-get update -y \
 && apt-get upgrade -y \
 && apt-get install nodejs -y \
 && npm install -g \
    npm@10.7.0 \
    oav@latest

## install package.json devdependencies
RUN npm install

ENTRYPOINT ["/bin/bash"]