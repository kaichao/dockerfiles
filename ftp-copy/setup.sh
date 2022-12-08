#!/bin/bash

# remote
# curlftpfs -f -v -o debug,ftpfs_debug=3 -o allow_other -o ssl ${FTP_URL} /remote
mkdir -p /remote
curlftpfs -o ssl ${FTP_URL} /remote
