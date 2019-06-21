#!/bin/sh
set -e

CRONJOB="$CRON_SCHEDULE $@"

echo "This cron job will be added :"
echo "$CRONJOB"

echo "Installing the cron job..."
echo "$CRONJOB" > /etc/crontabs/root

echo "We run the command once (initial check)..."
eval "$@"

# run the CMD
echo "First sync was successful, starting cron !"
crond -f
