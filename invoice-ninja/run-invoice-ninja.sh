#!/bin/bash
#mysql -h db -u root -proot < /var/database-setup.sql

php /var/www/invoice-ninja/artisan migrate --seed

./run.sh