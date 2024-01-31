FROM mcr.microsoft.com/cbl-mariner/base/core:2.0

RUN tdnf -y update && \
    tdnf -y install git && \
    tdnf clean all

RUN mkdir -p /usr/data/specrepo/

COPY .git /usr/data/specrepo/.git

WORKDIR /usr/data/scripts/
COPY run.sh run.sh
RUN chmod +x run.sh

RUN mkdir -p /usr/data/openapispecs/
WORKDIR /usr/data/openapispecs
ENTRYPOINT /usr/data/scripts/run.sh
