# docker-rclone-backup

This is a very lightweight Docker image that runs rclone as a cronjob (inspired from https://github.com/openbridge/ob_bulkstash).

Rclone being entierly configurable with environment variables (https://rclone.org/docs/#environment-variables), it should be pretty flexible.

See on Docker hub : https://hub.docker.com/r/olivierdalang/rclone-backup

## Usage

These are the env vars to configure :

- `RCLONE_CRON_SCHEDULE=0 0 * * *` : the cron schedule for the sync job (see cron doc)
- `RCLONE_COMMAND=copy` : the rclond command (most common is `copy` or `sync`)
- `RCLONE_SOURCE_PATH` : the source path, can be a local directory, or a remote directory if prefixed with `MYREMOTE:`
- `RCLONE_DESTINATION_PATH` : the destination path, can be a local directory, or a remote directory if prefixed with `MYREMOTE:`
- `RCLONE_CONFIG_MYREMOTE_TYPE` : provider type of MYREMOTE (e.g. `dropbox`, `s3`, ...)
- `RCLONE_CONFIG_MYREMOTE_...` : provider specific setting

You can define two remotes to copy/sync from remote to remote.

These settings come together in the crontab like this :
```
$RCLONE_CRON_SCHEDULE rclone $RCLONE_COMMAND -v "$RCLONE_SOURCE_PATH" "$RCLONE_DESTINATION_PATH"
```

## Example

Example `docker-compose.yml` to backup a docker volume to Dropbox.

```
version: '3.4'
services:

  ... your other services here

  backup:
    image: olivierdalang/rclone-backup:latest
    environment:
      - RCLONE_CRON_SCHEDULE=0 * * * *
      - RCLONE_COMMAND=sync
      - RCLONE_SOURCE_PATH=/your_data_volume
      - RCLONE_DESTINATION_PATH=MYDROPBOX:some_path_here
      - RCLONE_CONFIG_MYDROPBOX_TYPE=dropbox
      - RCLONE_CONFIG_MYDROPBOX_CLIENT_ID=xxx
      - RCLONE_CONFIG_MYDROPBOX_CLIENT_SECRET=yyy
      - RCLONE_CONFIG_MYDROPBOX_TOKEN={"access_token":"zzz","token_type":"bearer","expiry":"0001-01-01T00:00:00Z"}
    volumes:
      - ./your_data_volume:/your_data_volume
```

## Publishing

Images are auto-built from github.


|Git              |Docker tag|Notes |
|-----------------|----------|------|
|`master` branch  |`latest`  |Unstable|
|`0.0.0` branches |`0.0.0`   |Unstable, version represents rclone version|
|`0.0.0-rX` tags  |`0.0.0-rX`|Stable, corresponds to rclone version docker image stable release number|

### Manual push

```
docker build -t olivierdalang/rclone-backup:latest .
docker push olivierdalang/rclone-backup:latest
```
