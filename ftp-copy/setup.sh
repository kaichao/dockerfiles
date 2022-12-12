#!/bin/bash

# curlftpfs -f -v -o debug,ftpfs_debug=3 -o allow_other -o ssl ${FTP_URL} /remote

if [[ $REMOTE_URL =~ (ftp://([^:]+:[^@]+@)?[^/:]+(:[^/]+)?)(/.*) ]]; then
    ftp_url=${BASH_REMATCH[1]}
    curlftpfs -o ssl ${ftp_url} /remote
else
    echo "REMOTE_URL did not match regex!" >&2
fi

if [[ $RAM_DISK_GB != '' ]]; then 
    mount -t tmpfs -o size=${RAM_DISK_GB}G,mode=0777 tmpfs /work
    code=$?
    echo "create_tmpfs,ret_code="$code
fi
