#!/usr/bin/env bash

# source worker-utl.sh
BASE_DIR=/data

FIFO=$BASE_DIR/run/fifo
FIFO_LOCK=$BASE_DIR/run/fifo.lck

LOG=$BASE_DIR/run/fast-frb.log
LOG_LOCK=$BASE_DIR/run/log.lck

ip_addr=$(/app/sbin/get-ip-from-proc.sh)

function job() {
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

function log() {
    exec 5<$LOG_LOCK        # open the log lock file
    flock 5                 # obtain the log lock
    echo $* >> $LOG         # put log message in the log file
    flock -u 5              # release the log lock
    exec 5<&-               # close the log lock file
}

## This is the worker to read from the fifo.
function work() {
    ## first open the fifo and fifo lock for reading.
    exec 3<$FIFO
    exec 4<$FIFO_LOCK

    while true; do
        # read from the fifo
        flock 4                     # obtain the fifo lock
        read -su 3 data_file        # read into data_file
        read_status=$?              # save the exit status of read
        flock -u 4                  # release the fifo lock

        echo "read_status:" $read_status

        # check the line read.
        if [[ $read_status -ne 0 ]]; then
            break # EOF.
        fi

        # if [ "$data_file" == "EOF" ]; then
        #     break
        # fi

        ## Run the job in a subshell, any exit calls do not kill the job process.
        ( job $1 "$data_file" $2)
    done
    # clean up the fd(s)
    exec 3<&-
    exec 4<&-
    log ip:$ip_addr/gpu:$2 " has done working"
}

# param1: analysis script
# param2: gpu id
echo "input params" $*
work $*
