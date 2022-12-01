#!/bin/bash

set -e

if [ $TRANSPORT_TYPE = "rsync" ]; then
    echo "starting rsyncd on port $RSYNC_PORT"

    if [ $ENABLE_LOCAL_RELAY = "yes" ]; then
        rsync --daemon --port $RSYNC_PORT --no-detach --temp-dir=/tmp --log-file /dev/stdout
    else
        rsync --daemon --port $RSYNC_PORT --no-detach --log-file /dev/stdout
    fi
else 
    echo "starting sshd on port $SSH_PORT"
    /usr/sbin/sshd -p $SSH_PORT -D
fi
