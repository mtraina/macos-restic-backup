#!/bin/bash
source "backup-eu.cfg"

export RESTIC_PASSWORD=$RESTIC_PASSWORD
export B2_ACCOUNT_ID=$B2_ACCOUNT_ID
export B2_ACCOUNT_KEY=$B2_ACCOUNT_KEY

/usr/local/bin/restic -v -r b2:matteo-backup-eu backup /Users/matteo/Documents -o b2.connections=10
/usr/local/bin/restic -v -r b2:matteo-backup-eu forget --keep-last 10

export RESTIC_PASSWORD=
export B2_ACCOUNT_ID=
export B2_ACCOUNT_KEY=

exit 0