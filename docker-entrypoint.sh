#!/bin/sh
set -e

# constructing the command
COMMAND="rclone copy -v \"$RCLONE_SOURCE_PATH\" \"$RCLONE_DESTINATION_PATH\""

# debug statement
echo "The command is : $COMMAND"

# running the command once, so that the container stops if it is misconfigured
eval "$COMMAND"

# setting up cron
echo "$RCLONE_CRON_SCHEDULE $COMMAND" > /etc/crontabs/root

# run the CMD
exec "$@"
