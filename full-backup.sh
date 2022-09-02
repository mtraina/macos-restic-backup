#!/bin/bash

echo "start eu backup" && cd .backup/eu && ./backup-eu.sh && echo "start uswest backup" && cd ../uswest && ./backup-uswest.sh

exit 0