#!/bin/bash

# Load runtime variables in docker-compose.yml
printenv | grep -v ^_ | grep -v HOSTNAME | sort >> /etc/environment

# set cron interval
if [ -z "${CRON_MINUTES}" ]; then
    CRON_MINUTES=1
fi
cmd="sed -i 's/CRON_MINUTES/"${CRON_MINUTES}"/g' /etc/cron.d/crontab"
eval ${cmd}

if [ -z "${CRON_HOURS}" ]; then
    CRON_HOURS=1
fi
cmd="sed -i 's/CRON_HOURS/"${CRON_HOURS}"/g' /etc/cron.d/crontab"
eval ${cmd}

if [ -z "${CRON_WEEKDAYS}" ]; then
    CRON_WEEKDAYS=1
fi
cmd="sed -i 's/CRON_WEEKDAYS/"${CRON_WEEKDAYS}"/g' /etc/cron.d/crontab"
eval ${cmd}
