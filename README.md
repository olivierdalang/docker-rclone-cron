# docker-rclone-cron

This is a very lightweight Docker image that runs **rclone** as
a **cronjob** (inspired from https://github.com/openbridge/ob_bulkstash).

It makes **backuping tasks** or other **syncing tasks** very easy.
Rclone being entierly configurable with environment variables
(https://rclone.org/docs/#environment-variables), it should be
pretty flexible.

See on Docker hub : https://hub.docker.com/r/olivierdalang/rclone-cron

## Usage

```
docker run \
    -v ./backups/:/backups/ \
    -e "CRON_SCHEDULE=0 0 * * *" \
    -e "COMMAND=rclone copy /backups/ MYREMOTE:/path/where/to/backup/" \
    -e "RCLONE_CONFIG_MYREMOTE_TYPE=s3" \
    -e "RCLONE_CONFIG_MYREMOTE_ACCESS_KEY_ID=XXX" \
    -e "RCLONE_CONFIG_MYREMOTE_SECRET_ACCESS_KEY=YYY" \
    olivierdalang/rclone-cron
```

`COMMAND` is executed once on container startup (to test the config), and if
it succeeded, cron will start in foreground.

See rclone's documentation for the command syntax and the `RCLONE_CONFIG_*`
configuration. See cron documentation for `CRON_SCHEDULE`.

You could also define two remotes to do a remote-to-remote sync/copy.

## Example

Example `docker-compose.yml` to sync a docker volume to Dropbox.

```
version: '3.4'
services:

  ... your other services here

  backup:
    image: olivierdalang/rclone-cron:latest
    environment:
      - CRON_SCHEDULE=0 * * * *
      - COMMAND=rclone sync -v /your_data_volume MYDROPBOX:some_path_here
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
|`0.0.0-rX` tags  |`0.0.0-rX`|Stable, version represents rclone version and rX the stable build number|

### Manual push

```
docker build -t olivierdalang/rclone-cron:latest .
docker push olivierdalang/rclone-cron:latest
```
