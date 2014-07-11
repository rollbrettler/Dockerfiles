#!/bin/bash
#mysql -h db -u root -proot < /var/database-setup.sql

FILE="/var/www/invoice-ninja/.lock-artisan"

if [ -f $FILE ];
then
    
else
    php /var/www/invoice-ninja/artisan migrate --seed
    touch FILE
fi

./run.sh