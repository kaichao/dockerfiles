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

printf "[DEBUG]ACTION=%s, REMOTE_URL=%s, LOCAL_ROOT=%s, file=%s\n"  $ACTION $REMOTE_URL $LOCAL_ROOT $1
printf "[DEBUG]ftp_ur=%s remote_dir=%s, local_dir=%s, filename=%s \n" $ftp_url $remote_dir $local_dir $filename

if [[ $ENABLE_LOCAL_RELAY == 'yes' ]]; then 
    work_dir="/work"
else
    work_dir=$local_dir
fi

if [[ $ACTION == 'PUSH' ]]; then
    # curlftpfs mounted /remote
    cmd="mkdir -p /remote${remote_dir}"
    eval $cmd; code=$?
    [[ $code -ne 0 ]] && echo cmd:$cmd, error_code:$code && exit $code

    if [[ $ENABLE_LOCAL_RELAY == 'yes' ]]; then
        cmd="cp $local_dir/$filename /work"
        eval $cmd; code=$?
        [[ $code -ne 0 ]] && echo cmd:$cmd, error_code:$code && exit $code
    fi
    cmd="lftp -c \"open ${ftp_url}; cd ${remote_dir}; lcd ${work_dir}; put ${filename}\""
    echo [DEBUG]cmd:$cmd
    eval $cmd; code=$?
    if [[ $ENABLE_LOCAL_RELAY == 'yes' ]]; then
        rm -f /work/$filename
    fi
    [[ $code -ne 0 ]] && echo cmd:$cmd, error_code:$code && exit $code
elif [[ $ACTION == 'PULL' ]]; then
    # PULL
    cmd="mkdir -p ${local_dir}"
    eval $cmd; code=$?
    [[ $code -ne 0 ]] && echo cmd:$cmd, error_code:$code && exit $code

    cmd="lftp -e \"lcd ${work_dir};pget -n $NUM_PGET_CONN ${ftp_url}${remote_dir}/${filename};exit\""
    echo [DEBUG]cmd:$cmd
    eval $cmd; code=$?
    [[ $code -ne 0 ]] && echo cmd:$cmd, error_code:$code && exit $code

    if [[ $ENABLE_LOCAL_RELAY == 'yes' ]]; then
        mv /work/$filename $local_dir
    fi
elif [[ $ACTION == 'PUSH_RECHECK' ]]; then
    cmd="mkdir -p /remote${remote_dir}"
    eval $cmd; code=$?
    [[ $code -ne 0 ]] && echo cmd:$cmd, error_code:$code && exit $code

    # $ENABLE_LOCAL_RELAY == 'yes'
    cmd="cp $local_dir/$filename /work"
    eval $cmd; code=$?
    [[ $code -ne 0 ]] && echo cmd:$cmd, error_code:$code && exit $code

    # push to ftp-server
    cd /work
    cmd="lftp -c \"open ${ftp_url}; cd ${remote_dir}; lcd /work; put ${filename}\""
    echo [DEBUG]cmd:$cmd
    eval $cmd; code=$?
    if [[ $code -ne 0 ]]; then
        echo cmd:$cmd, error_code:$code
        rm -f /work/${filename} /work/${filename}.orig
        exit $code
    fi

    # re-pull from ftp-server
    mv /work/${filename} /work/${filename}.orig
    cmd="lftp -e \"lcd /work;get ${ftp_url}${remote_dir}/${filename};exit\""
    echo [DEBUG]cmd:$cmd
    eval $cmd; code=$?
    if [[ $code -ne 0 ]]; then
        echo cmd:$cmd, error_code:$code
        rm -f /work/${filename} /work/${filename}.orig
        exit $code
    fi

    # compare original file with re-pulled file.
    cmd="diff /work/${filename} /work/${filename}.orig"
    eval $cmd; code=$?
    rm -f /work/${filename} /work/${filename}.orig
    [[ $code -ne 0 ]] && echo cmd:$cmd, error_code:$code && exit $code
    echo "The original file or the returned file is the same."
fi

# lftp ${ftp_url} << EOF
#     cd ${remote_dir}
#     lcd ${work_dir}
#     put ${filename}
#     by
# EOF

exit $code
