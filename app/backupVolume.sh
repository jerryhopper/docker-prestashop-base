#!/bin/bash

THEDATE="$(date +%Y%m%d)"

VOLUME=$1
FILENAME=$2

if [ ! -d $PWD/backup ];then
  mkdir ./backup
fi


# Backup the www directory in a tar
docker run --rm -v $VOLUME:/app -v $PWD/backup:/backup ubuntu bash -c "cd /app && tar cvf ./$2.tar ." > /dev/null
