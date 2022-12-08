#!/bin/bash

filename=$(basename $1)
if [[ $REMOTE_ROOT == '/' ]]; then
    remote_dir=$(dirname /$1)
else
    remote_dir=$(dirname ${REMOTE_ROOT}/$1)
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
lftp ${FTP_URL} << EOF
    cd ${remote_dir}
    lcd ${local_dir}
    put ${filename}
    by
EOF

else
    # PULL
    mkdir -p /local${local_dir}
lftp ${FTP_URL} << EOF
    cd ${remote_dir}
    lcd ${local_dir}
    get ${filename}
    by
EOF

fi

code=$?
exit $code
