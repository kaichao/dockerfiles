## ftp-copy

ftp-copy is used to copy file from/to ftp-server.
In this container image, curlftpfs is used to mount ftp-server as a local file system to manipulate metadata, and lftp is used to perform actual file transfer.

## parameters

| parameter name   | Description  |
|  ----  | ----  |
| REMOTE_URL  | The format of REMOTE_URL is ftp://{user}:{pass}@{host}:{port}/{path} |
| LOCAL_ROOT  | The root directory for local file storage, default value is '/' |
| NUM_PGET_CONN  | Maximum number of connections to get the specified file using several connections, default value is 4 |
| ACTION  | The action of file copying, 'PUSH': local->ftp server; 'PULL': ftp server->local; 'PUSH_RECHECK': local->ftp server & ftp server->local , then check the consistency of the original file and the received file.The default value is 'PUSH' |
| ENABLE_RECHECK_SIZE  | For action equal to 'PUSH' or 'PULL', recheck the file size is consistent after the file transfer. The default value is 'yes' |
| ENABLE_LOCAL_RELAY  | Enable local machine as transfer relay if local files are stored on network storage. If ACTION is set to 'PUSH_RECHECK', ENABLE_LOCAL_RELAY is always yes. The default value is 'no' |
| RAM_DISK_GB  | The ramdisk size of the local machine transfer relay in GB. If set, this value should be greater than 2 times the maximum file bytes. The default value is 0, no ramdisk cache |

## usage

```
1. run /app/bin/setup.sh, mount ftp-server as local file system via curlftpfs;
2. run /app/bin/run.sh {filename}, copy file from/to ftp server via lftp.
```
