FROM mcr.microsoft.com/oss/mirror/docker.io/library/ubuntu:20.04

RUN mkdir -p /usr/data/specrepo/

COPY .git /usr/data/specrepo/.git

WORKDIR /usr/data/scripts/
COPY run.sh run.sh
RUN chmod +x run.sh

RUN mkdir -p /usr/data/openapispecs/
WORKDIR /usr/data/openapispecs
ENTRYPOINT /usr/data/scripts/run.sh
