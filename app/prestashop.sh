#!/bin/bash




# Set ownership
echo "Fix Ownership"
docker exec presta_beststout_shop bash -c "chown -R www-data:www-data /app"



# Set permissions
echo "Fix permissions"
docker exec presta_beststout_shop bash -c "chmod +w ./var/cache && chmod +w ./var/logs && chmod +w ./img && chmod +w ./mails && chmod +w ./modules && chmod +w ./translations && chmod +w ./upload && chmod +w ./download && chmod +w ./app/config && chmod +w ./app/Resources/tramslations"



