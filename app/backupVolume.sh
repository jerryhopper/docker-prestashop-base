#!/bin/bash

THEDATE="$(date +%Y%m%d)"

VOLUME=$1
FILENAME=$2

if [ "$1" = "" ];then
  echo "Missing 1st paramater (volume)"
  exit
fi
if [ "$2" = "" ];then
  echo "Missing 2nd paramater (filename), using volumename"
  FILENAME=$1
  
fi

if [ ! -d $PWD/backup ];then
  mkdir ./backup
fi

#docker run --rm -v $VOLUME:/app -v $PWD/backup:/backup ubuntu bash -c "ls -latr /"

#docker run --rm -v $VOLUME:/app -v $PWD/backup:/backup ubuntu bash -c "ls -latr /app"

# Backup the www directory in a tar
docker run --rm -v $VOLUME:/app -v $PWD/backup:/backup ubuntu bash -c "cd /app && tar cvf /backup/$FILENAME.tar ." > /dev/null
