#!/bin/bash

sed -e "s/\${SERVICE_NAME}/${SERVICE_NAME}/" \
    -e "s/\${SERVICE_PORT}/${SERVICE_PORT}/" \
    /config/envoy.yaml > /etc/envoy.yaml

/usr/local/bin/envoy -c /etc/envoy.yaml -l ${LOG_LEVEL} \
    --log-path /var/log/envoy/envoy.log
