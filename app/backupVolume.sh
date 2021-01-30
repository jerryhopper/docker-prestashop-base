#!/bin/bash

THEDATE="$(date +%Y%m%d)"

VOLUME=$1
FILENAME=$2


# Backup the www directory in a tar
docker run --rm --v /app:$VOLUME -v $PWD/backup:/backup ubuntu bash -c "cd /app && tar cvf ./$2.tar ." > /dev/null
