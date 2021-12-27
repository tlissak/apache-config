FROM php:8.1-apache

ENV COMPOSER_ALLOW_SUPERUSER=1

EXPOSE 80
WORKDIR /var/www/html

# git, unzip & zip are for composer
RUN apt-get update -qq && \
    apt-get install -qy \
    git \
    gnupg \
    unzip \
    zip

COPY --from=composer:2.0 /usr/bin/composer /usr/local/bin/composer

#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
#    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# PHP Extensions
RUN docker-php-ext-install -j$(nproc) pdo_mysql
COPY conf/php.ini /usr/local/etc/php/conf.d/app.ini

#COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

# Apache
#COPY conf/vhost.conf /etc/apache2/sites-available/000-default.conf
#COPY conf/apache.conf /etc/apache2/conf-available/amps-conf.conf
#COPY index.php /var/www/html/index.php

RUN a2enmod rewrite remoteip 
#RUN a2enconf amps-conf
