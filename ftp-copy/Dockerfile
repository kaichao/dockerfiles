FROM debian:11-slim

RUN echo "deb http://deb.debian.org/debian testing main" > /etc/apt/sources.list.d/bullseye-testing.list \
    && apt-get update \
    && apt-get install -y curlftpfs lftp \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mkdir /remote /local /work

ENV REMOTE_URL= \
    LOCAL_ROOT=/ \
    NUM_PGET_CONN=4 \
    ACTION=PUSH \
    ENABLE_LOCAL_RELAY= \
    RAM_DISK_GB=

COPY *.sh /app/bin/
