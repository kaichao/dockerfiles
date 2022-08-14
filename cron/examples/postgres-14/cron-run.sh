#!/bin/bash

# output environments
env | sort >> /var/log/cron.log 2>&1

echo "cronjob run AT $(date)" >> /var/log/cron.log 2>&1

POSTGRES_HOST=database
POSTGRES_DB=postgres
POSTGRES_USER=postgres

# run the task
psql -U ${POSTGRES_USER} -h ${POSTGRES_HOST} -d ${POSTGRES_DB} << EOF
    INSERT INTO tb(s) VALUES('hello');
EOF
