#!/bin/sh
set -e

CRONJOB="$CRON_SCHEDULE $COMMAND"

echo "This cron job will be added :"
echo "$CRONJOB"

echo "Installing the cron job..."
echo "$CRONJOB" > /etc/crontabs/root

echo "We run the command once (initial check)..."
eval "$COMMAND"

# run the CMD
echo "First sync was successful, starting cron !"
exec "$@"

