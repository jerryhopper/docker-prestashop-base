#!/bin/bash


#ACTION=$(( $1 == "" ? "" : $1  ))


ACTION=$1
DBUSER=$2
DBPASS=$3
DBNAME=$4
IMPORT=$5



if [ "$ACTION" = "" ];then
   echo "Usage:"
   echo "  backup <dbusername> <dbpassword> <dbname>"
   echo "  restore <dbusername> <dbpassword> <dbname> <importfile>"
   exit 1
fi

if [ "$DBUSER" = "" ];then
   echo "Missing 1st parameter (dbuser)"
   exit 1
fi

if [ "$DBPASS" = "" ];then
   echo "Missing 2nd parameter (dbpassword)"
   exit 1
fi

if [ "$DBNAME" = "" ];then
   echo "Missing 3rd parameter (dbname)"
   exit 1
fi




if [ "$1" = "backup" ];then
   
   
   exit 0
fi
if [ "$1" = "restore" ];then
   if [ "$IMPORT" = "" ];then
      echo "Missing 4rd parameter (outputfilename) Using default filename $THEDATE.sql.gz "

      docker exec -it mariadb:latest mysqldump -u $DBUSER -p$DBPASS $DBNAME | gzip > db.$THEDATE.sql.gz

   else   
      echo "Using 4rd parameter as filename $4.sql.gz "

      docker exec -it mariadb:latest mysqldump -u $DBUSER -p$DBPASS $DBNAME | gzip > $4.sql.gz

   fi   
   
   exit 0
fi


echo "Usage:"
echo "  backup <dbusername> <dbpassword> <dbname>"
echo "  restore <dbusername> <dbpassword> <dbname> <importfile>"
exit 1













THEDATE="$(date +%Y%m%d)"
THEEPOCH="$(date +%s)"





