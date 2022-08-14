FROM debian:11-slim

LABEL maintainer="kaichao"

# install pgsql client
RUN apt-get update \
    && apt-get install -y wget \
    && wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O /etc/apt/trusted.gpg.d/pgsql.asc \
    && echo "deb http://apt.postgresql.org/pub/repos/apt bullseye-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && apt-get update \
    && apt-get -y install postgresql-client \
    && apt-get --purge remove -y wget \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
