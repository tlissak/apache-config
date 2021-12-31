#!/bin/bash

wget -O composer-setup.php https://getcomposer.org/installer
php composer-setup.php --install-dir=/usr/local/bin --filename=composer

#chown -R $USER ~/.composer/
#mv composer.phar /usr/local/bin/composer
#composer update --ignore-platform-reqs