#!/bin/sh

#######################################
# install  :
# bash -c "$(wget -qLO - https://github.com/tlissak/settings/raw/main/install-apache-php.sh)"
# Bash script to install an Apache PHP stack For Debian based systems.
# Base on https://github.com/aamnah/bash-scripts/blob/master/install/amp_debian.sh
# Written by @AamnahAkram from http://aamnah.com

# In case of any errors just re-run the script. Nothing will be re-installed except for the packages with errors.
#######################################


source require.sh

color
catch_errors
#updateOS

#source apache.sh

#installDependencies
#installApache


source php.sh

installPhpVersion 8.0
installPHPExtentions
#installComposer
#cpPhpConfig
#enableApacheMods
#setWWWPermissions
#restartApache

#source ftp.sh

#installVsftpd
#enableFtpServiceStart
#editFtpConfig

#cleanup


#cp vhost.conf /etc/apache2/sites-available/

#create website give me a name
#create user for website
# give permissions to this user

#manuel : https://devcenter.heroku.com/articles/git
#deployment git :https://portent.com/blog/design-dev/github-auto-deploy-setup-guide.htm



#cpPhpConfigForce


#Unzip Archive
#Create local config ini
#composer update --working-dir=/var/www/html