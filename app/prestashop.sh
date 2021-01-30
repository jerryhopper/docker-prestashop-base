#!/bin/bash

THEFILE=prestashop_1.7.7.1.zip
DOWNLOADFILE=https://download.prestashop.com/download/releases/$THEFILE

CONTAINER=presta_beststout_shop


fixPermissions(){
  echo "Fix permissions"
  docker exec $CONTAINER bash -c "chmod +w ./var/cache && chmod +w ./var/logs && chmod +w ./img && chmod +w ./mails && chmod +w ./modules && chmod +w ./translations && chmod +w ./upload && chmod +w ./download && chmod +w ./app/config && chmod +w ./app/Resources/tramslations"
}

fixOwnership(){
  echo "Fix Ownership"
  docker exec $CONTAINER bash -c "chown -R www-data:www-data /app"  
}



if [ "$1"="install" ];then
  docker exec $CONTAINER bash -c "cd /app/web && wget $DOWNLOADFILE && unzip $THEFILE && rm -f $THEFILE && unzip prestashop.zip" 
  fixPermissions
  fixOwnership
  exit 0
fi


if [ "$1"="fixowner" ];then
  # Set ownership
  fixOwnership
  exit 0
fi


if [ "$1"="fixpermissions" ];then
  # Set permissions
  fixPermissions
  exit 0
fi






