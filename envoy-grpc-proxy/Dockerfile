FROM envoyproxy/envoy:v1.16.2

LABEL maintainer="kaichao"

USER root

COPY envoy.yaml /config/envoy.yaml
COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh

ENV SERVICE_NAME= \
    SERVICE_PORT= \
    LOG_LEVEL=warn
# CMD /usr/local/bin/envoy -c /etc/envoy/envoy.yaml -l trace --log-path /var/log/envoy/envoy_info.log
# CMD /usr/local/bin/envoy -c /etc/envoy/envoy.yaml -l  --log-path /var/log/envoy/envoy_info.log
ENTRYPOINT [ "/entrypoint.sh" ]
