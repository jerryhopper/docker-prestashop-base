#!/bin/bash

THEFILE=prestashop_1.7.7.1.zip
DOWNLOADFILE=https://download.prestashop.com/download/releases/$THEFILE

CONTAINER=prestashop_php
WEBCONTAINER=prestashop_web
DBCONTAINER=prestashop_database



disableShop(){
  echo "Disabling prestashop"
  docker exec $DBCONTAINER  mysql -u $DBUSER -p$DBPASS  -e "UPDATE ps_configuration SET value=0 WHERE `name` = 'PS_SHOP_ENABLE'"
}

enableShop(){
  echo "Enabling prestashop"
  docker exec $DBCONTAINER  mysql -u $DBUSER -p$DBPASS  -e "UPDATE ps_configuration SET value=1 WHERE `name` = 'PS_SHOP_ENABLE'"
}



fixPermissions(){
  echo "Fix permissions"
  docker exec $WEBCONTAINER sh -c "chmod +w /app/web/var/cache && chmod +w /app/web/var/logs && chmod +w /app/web/img && chmod +w /app/web/mails && chmod +w /app/web/modules && chmod +w /app/web/translations && chmod +w /app/web/upload && chmod +w /app/web/download && chmod +w /app/web/app/config && chmod +w /app/web/app/Resources/translations"
}

fixOwnership(){
  echo "Fix Ownership"
  docker exec $WEBCONTAINER sh -c "chown -R www-data:www-data /app"  
}

if [ "$1" = "clear" ];then
  docker exec $WEBCONTAINER sh -c "cd /app/web && rm -rf ./" 
  exit 0
fi






if [ "$1" = "install" ];then
  docker exec $WEBCONTAINER sh -c "rm -rf /app/web/* && mkdir -p /app/web/var/cache && cd /app/web && wget $DOWNLOADFILE && unzip $THEFILE && rm -f $THEFILE && unzip -o prestashop.zip" 
  fixPermissions
  fixOwnership
  exit 0
fi


if [ "$1" = "fixowner" ];then
  # Set ownership
  fixOwnership
  exit 0
fi


if [ "$1" = "fixpermissions" ];then
  # Set permissions
  fixPermissions
  exit 0
fi


if [ "$1" = "show" ];then
  docker exec $WEBCONTAINER sh -c "ls -latr /app && ls -latr /app/web" 
  exit 0
fi



