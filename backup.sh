#!/bin/bash

# reads the configuration passed by parameter
source $1

# checks if a backup is already happening
if [ -f "$PID_FILE" ]; then
  if ps -p $(cat $PID_FILE) > /dev/null; then
    echo $(date +"%Y-%m-%d %T") "File $PID_FILE exist. Probably backup is already in progress."
    exit 1
  else
    echo $(date +"%Y-%m-%d %T") "File $PID_FILE exist but process " $(cat $PID_FILE) " not found. Removing PID file."
    rm $PID_FILE
  fi
fi

# checks if a backup is starting before the threshold
if [ -f "$TIMESTAMP_FILE" ]; then
  time_run=$(cat "$TIMESTAMP_FILE")
  current_time=$(date +"%s")

  if [ "$current_time" -lt "$time_run" ]; then
    echo $(date +"%Y-%m-%d %T") "The backup started before 12h: $current_time < $time_run"
    exit 2
  fi
fi

echo $$ > $PID_FILE
echo $(date +"%Y-%m-%d %T") "Backup start"

export RESTIC_PASSWORD=$RESTIC_PASSWORD
export B2_ACCOUNT_ID=$B2_ACCOUNT_ID
export B2_ACCOUNT_KEY=$B2_ACCOUNT_KEY

/usr/local/bin/restic -v -r $REPOSITORY_NAME backup /Users/matteo/Documents -o b2.connections=10
/usr/local/bin/restic -v -r $REPOSITORY_NAME forget --keep-last 10

echo $(date +"%Y-%m-%d %T") "Backup finished"
echo $(date -v +12H +"%s") > $TIMESTAMP_FILE

rm $PID_FILE

export RESTIC_PASSWORD=
export B2_ACCOUNT_ID=
export B2_ACCOUNT_KEY=

exit 0