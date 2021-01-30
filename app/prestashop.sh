#!/bin/bash




docker exec -it  
chown -R www-data:www-data ./

chmod +w ./var/cache
chmod +w ./var/logs
chmod +w ./img
chmod +w ./mails
chmod +w ./modules
chmod +w ./translations
chmod +w ./upload
chmod +w ./download
chmod +w ./app/config
chmod +w ./app/Resources/tramslations

