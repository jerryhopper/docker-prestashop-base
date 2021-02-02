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
  docker exec $WEBCONTAINER sh -c "chmod 0755 /app/web/var/cache && chmod 0755 /app/web/var/logs && chmod 0755 /app/web/img && chmod 0755 /app/web/mails && chmod 0755 /app/web/modules && chmod 0755 /app/web/translations && chmod 0755 /app/web/upload && chmod 0755 /app/web/download && chmod 0755 /app/web/app/config && chmod 0755 /app/web/app/Resources/translations"
}

fixOwnership(){
  echo "Fix Ownership"
  docker exec $WEBCONTAINER sh -c "chown -R www-data:www-data /app"  
}


installPrestashop(){
  echo "Downloading & extracting prestashop"
  #docker exec $CONTAINER sh -c "rm -rf /app/web/* && mkdir -p /app/web/var/cache && cd /app/web && curl $DOWNLOADFILE -o $THEFILE && unzip $THEFILE && rm -f $THEFILE && unzip -o prestashop.zip" 
  docker exec $CONTAINER sh -c "rm -rf /app/web/* && mkdir -p /app/web && cd /app/web && curl $DOWNLOADFILE -o $THEFILE && unzip $THEFILE && rm -f $THEFILE" 
  fixPermissions
  fixOwnership
  
  DBROOTPWD=test123
  DBNAME=prestashop
  DBUSER=prestashop
  DBPASS=webturd123
  
  echo "Dropping database & user"
  docker exec -it $DBCONTAINER mysql -uroot -p$DBROOTPWD -e "DROP DATABASE $DBNAME;"
  docker exec -it $DBCONTAINER mysql -uroot -p$DBROOTPWD -e "DROP USER $DBUSER@'%';"


  echo "Create database & user"
  docker exec -it $DBCONTAINER mysql -uroot -p$DBROOTPWD -e "CREATE DATABASE $DBNAME /*\!40100 DEFAULT CHARACTER SET utf8 */;"
  docker exec -it $DBCONTAINER mysql -uroot -p$DBROOTPWD -e "CREATE USER $DBUSER@'%' IDENTIFIED BY '$DBPASS';"
  docker exec -it $DBCONTAINER mysql -uroot -p$DBROOTPWD -e "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$DBUSER'@'%';FLUSH PRIVILEGES;"
  docker exec -it $DBCONTAINER mysql -uroot -p$DBROOTPWD -e "FLUSH PRIVILEGES;"

}





if [ "$1" = "clear" ];then
  docker exec $WEBCONTAINER sh -c "cd /app/web && rm -rf ./*" 
  exit 0
fi






if [ "$1" = "install" ];then
  installPrestashop
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

echo "Usage:"
echo " install - installs prestashop in /app/web"
echo " fixowner - set www-data as owner. "
echo " fixpermissions - fixes permissions. "
echo " show - shows contents of /app and /app/web "



