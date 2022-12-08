# rsyncd
- Mount the root directory of the host to the /data of the container
- The following directories on the host are not allowed to be accessed by rsyncd in the container
    /bin/ /boot/ /dev/ /etc/ /proc/ /run/ /sys/ /var/ /usr/

## native rsyncd
```sh
docker run -d --rm --network host -v /etc/localtime:/etc/localtime:ro -v /:/data -e TZ=CST-8 kaichao/rsyncd 
```
## native rsyncd with ENABLE_LOCAL_RELAY
```sh
docker run -d --rm --network host -v /etc/localtime:/etc/localtime:ro -v /:/data -e TZ=CST-8 -e ENABLE_LOCAL_RELAY=yes kaichao/rsyncd 
```
## rsyncd over ssh
- default port is 2222
```sh
docker run -d --rm --network host -v /etc/localtime:/etc/localtime:ro -v /:/data -e TZ=CST-8 -e TRANSPORT_TYPE=ssh kaichao/rsyncd 
```
