FROM mcr.microsoft.com/devcontainers/typescript-node:20-bookworm

WORKDIR /workspaces/azure-rest-api-specs

RUN wget -q https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb \
    -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    git

RUN npm install -g oav@latest

ENTRYPOINT ["/bin/bash"]