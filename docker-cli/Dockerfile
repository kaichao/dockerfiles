FROM debian:11-slim

LABEL maintainer="kaichao"

# install docker-cli
RUN apt-get update \
    && apt-get install -y wget \
    && wget -qO - https://download.docker.com/linux/static/stable/x86_64/docker-20.10.21.tgz | tar xzf - -C /tmp \
    && mv /tmp/docker/docker /usr/local/bin/ \
    && rm -rf /tmp/docker \
    && apt-get --purge remove -y wget \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
