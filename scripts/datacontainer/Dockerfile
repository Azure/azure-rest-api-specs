FROM alpine:3.8

RUN apk update && \
    apk add git

RUN mkdir -p /usr/data/specrepo/

WORKDIR /usr/data/
RUN git clone https://github.com/sanjaiganesh/azure-rest-api-specs.git ./specrepo

WORKDIR /usr/data/scripts/
COPY run.sh run.sh
RUN chmod +x run.sh

RUN mkdir -p /usr/data/openapispecs/
WORKDIR /usr/data/openapispecs
ENTRYPOINT /usr/data/scripts/run.sh
