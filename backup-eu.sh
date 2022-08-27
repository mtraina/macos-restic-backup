#!/bin/bash

export RESTIC_PASSWORD=# fill it
export B2_ACCOUNT_ID=# fill it
export B2_ACCOUNT_KEY=# fill it

/usr/local/bin/restic -v -r b2:matteo-backup-eu backup /Users/matteo/Documents -o b2.connections=10
/usr/local/bin/restic -v -r b2:matteo-backup-eu forget --keep-last 10

export RESTIC_PASSWORD=# leave it blank
export B2_ACCOUNT_ID=# leave it blank
export B2_ACCOUNT_KEY=# leave it blank

exit 0