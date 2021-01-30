#!/bin/bash




if [ "$1"="install" ];then
  wget https://github.com/PrestaShop/PrestaShop/archive/1.7.7.1.zip
  exit 0
fi


if [ "$1"="fixowner" ];then
  # Set ownership
  echo "Fix Ownership"
  docker exec presta_beststout_shop bash -c "chown -R www-data:www-data /app"  
  exit 0
fi


if [ "$1"="fixpermissions" ];then
  # Set permissions
  echo "Fix permissions"
  docker exec presta_beststout_shop bash -c "chmod +w ./var/cache && chmod +w ./var/logs && chmod +w ./img && chmod +w ./mails && chmod +w ./modules && chmod +w ./translations && chmod +w ./upload && chmod +w ./download && chmod +w ./app/config && chmod +w ./app/Resources/tramslations"
  exit 0
fi






