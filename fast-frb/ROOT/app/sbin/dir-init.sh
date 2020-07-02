#!/usr/bin/env bash

# init shared base directory for input/output/run before job-running

# BASE_DIR=/data
BASE_DIR=../../../data

FIFO=$BASE_DIR/run/fifo
FIFO_LOCK=$BASE_DIR/run/fifo.lck

LOG=$BASE_DIR/run/fast-frb.log
LOG_LOCK=$BASE_DIR/run/log.lck

mkdir -p $BASE_DIR/run $BASE_DIR/input $BASE_DIR/output
cd $BASE_DIR/run
mkfifo $FIFO
touch $FIFO_LOCK $LOG_LOCK
