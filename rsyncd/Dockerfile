FROM debian:11-slim

LABEL maintainer="kaichao"

# install the newest version, rsync 3.2.6, zstd 1.5.2
RUN echo "deb http://deb.debian.org/debian testing main" > /etc/apt/sources.list.d/bullseye-testing.list \ 
    && apt-get update \
    && apt-get install -y rsync openssh-client zstd \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV TRANSPORT_TYPE=rsync \
    RSYNC_PORT=873 \
    SSH_PORT=2222 \
    ENABLE_LOCAL_RELAY=

COPY rootfs/ /

CMD run.sh
