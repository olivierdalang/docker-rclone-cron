#!/bin/sh
set -e

# setting up cron
echo "$RCLONE_CRON_SCHEDULE rclone copy -v $RCLONE_SOURCE_PATH $RCLONE_DESTINATION_PATH" > /etc/crontabs/root

# run the CMD
exec "$@"
