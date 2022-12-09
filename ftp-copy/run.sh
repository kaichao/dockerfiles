#!/bin/bash

filename=$(basename $1)

if [[ $REMOTE_URL =~ (ftp://([^:]+:[^@]+@)?[^/:]+(:[^/]+)?)(/.*) ]]; then
    ftp_url=${BASH_REMATCH[1]}
    remote_root=${BASH_REMATCH[4]}
else
    echo "REMOTE_URL did not match regex!" >&2
    exit 1
fi

if [[ $remote_root == '/' ]]; then
    remote_dir=$(dirname /$1)
else
    remote_dir=$(dirname ${remote_root}/$1)
fi

if [[ $LOCAL_ROOT == '/' ]]; then
    local_dir=$(dirname "/local"/$1)
else
    local_dir=$(dirname "/local"${LOCAL_ROOT}/$1)
fi

echo "filename:"$filename
echo "remote_dir:"$remote_dir
echo "local_dir:"$local_dir

if [[ $ACTION == 'PUSH' ]]; then
    mkdir -p /remote${remote_dir}
lftp ${ftp_url} << EOF
    cd ${remote_dir}
    lcd ${local_dir}
    put ${filename}
    by
EOF

else
    # PULL
    mkdir -p ${local_dir}
    lftp -e "lcd ${local_dir};pget -n $NUM_PGET_CONN ${ftp_url}${remote_dir}/${filename};exit"
fi

code=$?
exit $code
