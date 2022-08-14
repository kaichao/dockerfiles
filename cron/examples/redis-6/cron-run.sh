#!/bin/bash

# output environments
env | sort >> /var/log/cron.log 2>&1

echo "cronjob run AT $(date)" >> /var/log/cron.log 2>&1

# run the task
ds=$(date --iso-8601=ns)
redis-cli -h ${REDIS_HOST} -a ${REDIS_PW} lpush mydb:mytable ${ds}
