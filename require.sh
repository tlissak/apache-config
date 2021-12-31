#!/bin/bash
set -e
cat /etc/os-release
apt-get -y update
apt-get -y upgrade
apt-get -y install wget
apt-get install -y lsb-release ca-certificates apt-transport-https software-properties-common
apt-get install -y gnupg2