## ftp-copy

ftp-copy is used to copy file from/to ftp-server.
In this container image, curlftpfs is used to mount ftp-server as a local file system to manipulate metadata, and lftp is used to perform actual data transfer.

## parameters

| parameter name   | Description  |
|  ----  | ----  |
| REMOTE_URL  | The format of REMOTE_URL is ftp://{user}:{pass}@{host}:{port}/{path} |
| LOCAL_ROOT  | The root directory for local file storage, default value is '/' |
| NUM_PGET_CONN  | Maximum number of connections to get the specified file using several connections, default value is 4 |
| ACTION  | The direction of file copying, 'PUSH': local->ftp server; 'PULL': ftp server->local; default value is 'PUSH' |


## usage

```
1. run /app/bin/setup.sh, mount ftp-server as local file system;
2. run /app/bin/run.sh filename, copy file from/to ftp server.
```
