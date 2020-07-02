#!/usr/bin/env bash

SOCK_SERVER=10.10.10.29/3334

BASE_DIR=/data

FIFO=$BASE_DIR/run/fifo
FIFO_LOCK=$BASE_DIR/run/fifo.lck

LOG=$BASE_DIR/run/fast-frb.log
LOG_LOCK=$BASE_DIR/run/log.lck

ip_addr=$(/app/sbin/get-ip-from-proc.sh)

job() {
    exec_file=$1
    data_file=$2
    gpu_id=$3
    echo processing file:$data_file 

    read up rest </proc/uptime; t1="${up%.*}${up#*.}"

    ## run the work ....
    $exec_file $data_file

    read up rest </proc/uptime; t2="${up%.*}${up#*.}"
    millisec=$(( 10*(t2-t1) ))
    echo "\$data_file: $data_file, time: ${millisec}ms"
    log $data_file,${millisec}ms,$ip_addr,$gpu_id    
}

log() {
    exec 5<$LOG_LOCK        # open the log lock file
    flock 5                 # obtain the log lock
    echo $* >> $LOG         # put log message in the log file
    flock -u 5              # release the log lock
    exec 5<&-               # close the log lock file
}

## This is the worker to read from the socket.
function work() {
    while true; do
        # read from the job-server
        data_file=$(cat < /dev/tcp/$SOCK_SERVER)
        # check the line read.
        if [[ $read_status -ne 0 ]]; then
            break # EOF.
        fi

        if [ "$data_file" == "EOF" ]; then
            break
        fi

        ## Run the job in a subshell, any exit calls do not kill the job process.
        ( job $1 "$data_file" $2)
    done
    log ip:$ip_addr/gpu:$2 " has done working"
}

work $*
