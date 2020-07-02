#!/usr/bin/env bash

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
