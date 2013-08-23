#!/bin/sh
apt-get update
apt-get install -y python-software-properties
add-apt-repository -y ppa:guilhem-fr/swftools
apt-get update
apt-get install -y mysql-server imagemagick ffmpeg libreoffice openjdk-7-jdk swftools libjodconverter-java ffmpeg ttf-mscorefonts-installer
