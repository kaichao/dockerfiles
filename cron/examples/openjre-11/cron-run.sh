#!/bin/bash

# output environments
env | sort >> /var/log/cron.log 2>&1

echo "cronjob run AT $(date)" >> /var/log/cron.log 2>&1

# run the task
java -jar /HelloWorld.jar >> /var/log/cron.log 2>&1
