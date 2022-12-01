# rsyncd

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
