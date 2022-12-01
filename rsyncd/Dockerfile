FROM debian:11-slim

LABEL maintainer="kaichao"

# install rsync
RUN apt-get update \
    && apt-get install -y rsync openssh-client \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV TRANSPORT_TYPE=rsync \
    RSYNC_PORT=873 \
    SSH_PORT=2222 \
    ENABLE_LOCAL_RELAY=

COPY rootfs/ /

CMD run.sh
