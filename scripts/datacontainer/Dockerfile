ARG SOURCE_DIRECTORY
FROM alpine:3.8

RUN apk update && \
    apk add git

RUN mkdir -p /usr/data/specrepo/
COPY $SOURCE_DIRECTORY/.git /usr/data/specrepo/.git

RUN mkdir -p /usr/data/openapispecs/
WORKDIR /usr/data/openapispecs

WORKDIR /usr/data/scripts/
COPY run.sh run.sh
RUN chmod +x run.sh
ENTRYPOINT /usr/data/scripts/run.sh
