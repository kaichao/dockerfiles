ARG BASE_IMAGE

FROM ${BASE_IMAGE}

LABEL maintainer="Kaichao Wu"

RUN  \
    apt-get update --quiet > /dev/null \
    && apt-get install -y cron \
# apt-get purge -y --auto-remove $buildDeps \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# set static environment variables from image
RUN /bin/bash -c "declare -p | grep -Ev 'BASHOPTS|BASH_VERSINFO|EUID|PPID|SHELLOPTS|UID|HOSTNAME|PGHOST' > /container.env"

# COPY --from=0 /ROOT-ssh/ /

COPY ROOT/ /

# Apply cron job & Create the log file to be able to run tail
RUN chmod 0644 /etc/cron.d/crontab && touch /var/log/cron.log
# Run the command on container startup
CMD cron-init.sh && cron && tail -f /var/log/cron.log

# ONBUILD COPY --from=hub.cstcloud.cn/scalebox/base:dev /usr/local/sbin/goagent /usr/local/sbin/
# ONBUILD ENTRYPOINT goagent
