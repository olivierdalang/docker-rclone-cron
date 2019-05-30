# docker-rclone-backup

This is a very lightweight Docker image that runs rclone as a cronjob (inspired from https://github.com/openbridge/ob_bulkstash).

Rclone being entierly configurable with environment variables (https://rclone.org/docs/#environment-variables), it should be pretty flexible.

See on Docker hub : https://hub.docker.com/r/olivierdalang/rclone-backup

## Usage

Example setup for Dropbox (`docker-compose.yml`) :

```
version: '3.4'
services:

  ... your other services here

  backup:
    image: olivierdalang/rclone-backup:latest
    environment:
      - RCLONE_CRON_SCHEDULE=0 * * * *
      - RCLONE_SOURCE_PATH=/your_data_volume
      - RCLONE_DESTINATION_PATH=MYDROPBOX:some_path_here
      - RCLONE_CONFIG_MYDROPBOX_TYPE=dropbox
      - RCLONE_CONFIG_MYDROPBOX_CLIENT_ID=xxx
      - RCLONE_CONFIG_MYDROPBOX_CLIENT_SECRET=yyy
      - RCLONE_CONFIG_MYDROPBOX_TOKEN={"access_token":"zzz","token_type":"bearer","expiry":"0001-01-01T00:00:00Z"}
    volumes:
      - ./your_data_volume:/your_data_volume
```
