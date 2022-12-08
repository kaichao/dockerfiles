## ftp-copy

ftp-copy is used to copy file from/to ftp-server.
In this container image, curlftpfs is used to mount ftp-server as a local file system to manipulate metadata, and lftp is used to perform actual data transfer.

## parameters

| parameter name   | Description  |
|  ----  | ----  |
| FTP_URL  | The format of FTP_URL is ftp://{user}:{pass}@{host}:{port} |
| LOCAL_ROOT  | The root directory for local file storage, the default value is '/' |
| REMOTE_ROOT | The root directory of the ftp server, the default value is '/' |
| ACTION  | The direction of file copying, 'PUSH': local->ftp server; 'PULL': ftp server->local. The default is 'PUSH' |

## usage

```
1. run /app/bin/setup.sh, mount ftp-server as local file system;
2. run /app/bin/run.sh filename, copy file from/to ftp server.
```