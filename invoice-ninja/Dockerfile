# invoice-ninja
FROM php:5.6-apache

MAINTAINER Tim Petter <tim@timpetter.de>

ENV VERSION v2.3.0

ENV DB_TYPE mysql
ENV DB_HOST localhost
ENV DB_DATABASE forge
ENV DATBASE_USER forge
ENV DB_PASSWORD forge
ENV APP_URL http://www.invoiceninja.com/

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        git \
    && docker-php-ext-install mbstring curl mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

WORKDIR /var/www/html

RUN git clone https://github.com/hillelcoren/invoice-ninja.git /var/www/html/ \
    && git checkout $VERSION \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer install \
    && cp bootstrap/environment.default.php bootstrap/environment.php

EXPOSE 80
