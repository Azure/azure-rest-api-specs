FROM mcr.microsoft.com/cbl-mariner/distroless/base:1.0

RUN apk update && \
    apk add git

RUN mkdir -p /usr/data/specrepo/
COPY .git /usr/data/specrepo/.git

WORKDIR /usr/data/scripts/
COPY run.sh run.sh
RUN chmod +x run.sh

RUN mkdir -p /usr/data/openapispecs/
WORKDIR /usr/data/openapispecs
ENTRYPOINT /usr/data/scripts/run.sh
