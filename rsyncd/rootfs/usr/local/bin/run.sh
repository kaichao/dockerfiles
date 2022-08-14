#!/bin/bash

set -e

if [ $TRANSPORT_TYPE = "rsync" ]; then 
    rsync --daemon --port $RSYNC_PORT --no-detach --log-file /dev/stdout 
else 
    exec /usr/sbin/sshd -p $SSH_PORT -D
fi 
