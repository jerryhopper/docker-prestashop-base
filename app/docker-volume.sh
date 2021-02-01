#!/bin/bash

THEDATE="$(date +%Y%m%d)"

ACTION=$1
VOLUME=$2
FILENAME=$3



function retoreVolume(){
  #docker run --rm -v $VOLUME:/app -v $PWD/backup:/backup ubuntu bash -c "ls -latr /"
  #docker run --rm -v $VOLUME:/app -v $PWD/backup:/backup ubuntu bash -c "ls -latr /app"  
  # Backup the www directory in a tar
  docker run --rm -v $VOLUME:/app -v $PWD/backup:/backup ubuntu bash -c "cd /app && tar cvf /backup/$FILENAME.tar ."
}


function backupVolume(){
  #docker run --rm -v $VOLUME:/app -v $PWD/backup:/backup ubuntu bash -c "ls -latr /"
  #docker run --rm -v $VOLUME:/app -v $PWD/backup:/backup ubuntu bash -c "ls -latr /app"  
  # Backup the www directory in a tar
  #> /dev/null
  docker run --rm -v $VOLUME:/app -v $PWD/backup:/backup ubuntu bash -c "cd /app && tar cvf /backup/$FILENAME.tar ." 
}


if [ "$ACTION" = "backup" ];then
  if [ "$VOLUME" = "" ];then
    echo "Missing 2nd paramater (volume)"
    exit
  fi
  if [ "$FILENAME" = "" ];then
    echo "Missing 2nd paramater (filename), using volumename"
    FILENAME=$2
  fi
  backupVolume
  exit
fi

if [ "$ACTION" = "restore" ];then
  if [ "$VOLUME" = "" ];then
    echo "Missing 1st paramater (volume)"
    exit
  fi
  retoreVolume
  exit 
fi


echo "Usage:"
echo "  docker-volume backup"
echo "  docker-volume restore"


