#!/bin/sh

#######################################
# Bash script to install Apache PHP stack For Debian based systems.
# login with root user
# run simply this line :
# bash -c "$(wget -qLO - https://github.com/tlissak/settings/raw/main/install.sh)"
#######################################


source require.sh

color
catch_errors
updateOS

source apache.sh

installDependencies
installApache
replaceApacheDefaultSite

source php.sh

installPhpVersion 8.3
installPHPExtentions
installComposer
cpPhpConfig
enableApacheMods
setWWWPermissions

restartApache

cleanup

#manuel : https://devcenter.heroku.com/articles/git
#deployment git :https://portent.com/blog/design-dev/github-auto-deploy-setup-guide.htm


#source ftp.sh
#installVsftpd
#enableFtpServiceStart
#editFtpConfig


#Unzip Archive
#Create local config ini
#composer update --working-dir=/var/www/html
