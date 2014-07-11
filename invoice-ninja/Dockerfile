# invoice-ninja version 1.2.1
FROM tutum/apache-php:latest

MAINTAINER Tim Petter

# ubdate first
RUN apt-get update --assume-yes --quiet
RUN apt-get upgrade --assume-yes --quiet

# install some basic tools
RUN apt-get install --assume-yes --quiet curl wget

# install apache
RUN apt-get install --assume-yes --quiet apache2

# install php
RUN apt-get install --assume-yes --quiet php5 php5-curl php5-gd php5-imagick php-pear php5-imap php5-cli php5-cgi php5-mysql libapache2-mod-php5 php5-mcrypt

# apt get cleanup
RUN apt-get clean

# configuration for invoice ninja
RUN php5enmod mcrypt
RUN a2enmod rewrite
RUN rm -fr /app

# add invoice ninja files
RUN mkdir /var/www/invoice-ninja/
ADD invoice-ninja /var/www/invoice-ninja
RUN chown -R www-data:www-data /var/www/invoice-ninja

# add files
ADD docker-apache.conf /etc/apache2/sites-enabled/000-default.conf
ADD database.php /var/www/invoice-ninja/app/config/database.php
ADD run-invoice-ninja.sh /run-invoice-ninja.sh
ADD database-setup.sql /var/database-setup.sql

EXPOSE 80
CMD ["/run-invoice-ninja.sh"]