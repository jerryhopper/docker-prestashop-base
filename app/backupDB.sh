#!/bin/bash

if [ "$1" = "" ];then
   echo "Missing 1st parameter (dbuser)"
   exit 1
fi

if [ "$2" = "" ];then
   echo "Missing 2nd parameter (dbpassword)"
   exit 1
fi

if [ "$3" = "" ];then
   echo "Missing 3rd parameter (dbname)"
   exit 1
fi


DBUSER=$1
DBPASS=$2
DBNAME=$3

THEDATE="$(date +%Y%m%d)"
THEEPOCH="$(date +%s)"

if [ "$4" = "" ];then
   echo "Missing 4rd parameter (outputfilename) Using default filename $THEDATE.sql.gz "
   
   docker exec -it mariadb:latest mysqldump -u $DBUSER -p$DBPASS $DBNAME | gzip > db.$THEDATE.sql.gz

else   
   echo "Using 4rd parameter as filename $4.sql.gz "
   
   docker exec -it mariadb:latest mysqldump -u $DBUSER -p$DBPASS $DBNAME | gzip > $4.sql.gz
   
fi



