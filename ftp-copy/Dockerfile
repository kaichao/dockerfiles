FROM debian:11-slim

RUN echo "deb http://deb.debian.org/debian testing main" > /etc/apt/sources.list.d/bullseye-testing.list \
    && apt-get update \
    && apt-get install -y curlftpfs lftp \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV FTP_URL= \
    LOCAL_ROOT=/ \
    REMOTE_ROOT=/ \
    ACTION=PUSH

COPY *.sh /app/bin/
