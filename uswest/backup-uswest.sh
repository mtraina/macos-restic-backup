#!/bin/bash
source "backup-uswest.cfg"

/usr/local/bin/restic -v -r b2:matteo-backup-uswest backup /Users/matteo/Documents -o b2.connections=10
/usr/local/bin/restic -v -r b2:matteo-backup-uswest forget --keep-last 10

export RESTIC_PASSWORD=
export B2_ACCOUNT_ID=
export B2_ACCOUNT_KEY=

exit 0