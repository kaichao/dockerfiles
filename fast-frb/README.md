## Build docker image
```sh
mkdir $BASE_DIR/app && cd $BASE_DIR/app
git clone git://git.code.sf.net/p/psrchive/code psrchive
git clone git://git.code.sf.net/p/dspsr/code dspsr
git clone https://github.com/ajameson/dedisp.git && sed -i 's/sm_30/sm_60/g' dedisp/Makefile.inc
git clone https://git.code.sf.net/p/psrdada/code psrdada
git clone https://git.code.sf.net/p/heimdall-astro/code heimdall

cd $BASE_DIR
make build

# transfer docker image to another node
docker save fast/heimdall | gzip | pv | ssh gl16 'gzip -d | docker load'
```

## Data preparation
1. Initialize directory /data using ROOT/app/sbin/dir-init.sh, and put input data into /data/input;
2. put your analysis script into $BASE_DIR/bin 

## Multi-node job queue based on socket
1. start sock server, put all the files to be processed in the queue(add N*M EOFs)
```
cd $$BASE_DIR/sock-server && make build && ./sock-server -f ../data/all.list
```
2. Start N containers on each node, ready to process data files
```
cd $$BASE_DIR && make run-sock
```

## Single node job queue based on FIFO
1. Start 8 containers on each node, ready to process data files
```sh
cd $$BASE_DIR && make run-fifo
```
2. Put all filename list to be processed to the FIFO
```sh
cat files.list | while read line; do echo $line >> $BASE_DIR/data/run/fifo; done
```

## References
* [Simple job queue in Bash using a FIFO](https://blog.garage-coding.com/2016/02/05/bash-fifo-jobqueue.html)
* [A Job Queue in BASH](https://hackthology.com/a-job-queue-in-bash.html)
* [UNIX fifo concurrent read from a named pipe](https://www.unix.com/shell-programming-and-scripting/277144-unix-fifo-concurrent-read-named-pipe.html)
* [Bash One-Liners Explained, Part III: All about redirections](https://catonmat.net/bash-one-liners-explained-part-three)
* [Using in/out named pipes for a TCP connection](https://unix.stackexchange.com/questions/39362/using-in-out-named-pipes-for-a-tcp-connection)
* [Bridge Unix domain socket with a FIFO and log file](https://stackoverflow.com/questions/18939463/bridge-unix-domain-socket-with-a-fifo-and-log-file)
* [How to Use Netcat Commands: Examples and Cheat Sheets](https://www.varonis.com/blog/netcat-commands/)
