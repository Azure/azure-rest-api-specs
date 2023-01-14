FROM mcr.microsoft.com/mirror/docker/library/ubuntu:22.04

RUN apt-get -y update
RUN apt-get -y install git

RUN mkdir -p /usr/data/specrepo/

COPY .git /usr/data/specrepo/.git

WORKDIR /usr/data/scripts/
COPY run.sh run.sh
RUN chmod +x run.sh

RUN mkdir -p /usr/data/openapispecs/
WORKDIR /usr/data/openapispecs
ENTRYPOINT /usr/data/scripts/run.sh
