#!/bin/bash

####################################################
## ZABBIX INSTALL SCRIPT
##
## Zabbix 5 - Ubuntu 20 - MySQL - NGINX
####################################################

sudo apt install mariadb-server -y
sudo systemctl start mysqld.service
sudo systemctl enable mysqld.service

sudo wget https://repo.zabbix.com/zabbix/5.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.0-1+focal_all.deb
sudo dpkg -i zabbix-release_5.0-1+focal_all.deb
sudo apt update

sudo apt install zabbix-server-mysql -y
sudo apt install zabbix-frontend-php -y
sudo apt install zabbix-nginx-conf -y
sudo apt install zabbix-agent -y
sudo apt install git curl php-curl mc htop -y

###
### 45Yn9aURSI6j - MySQL (MariaDB) zabbix user password. Replace with your password
### This password must be changed in the file /etc/zabbix/zabbix_server.conf for the parameter DBPassword=45Yn9aURSI6j
###
sudo mysql -uroot -e "create database zabbix character set utf8 collate utf8_bin;"
sudo mysql -uroot -e "grant all privileges on zabbix.* to zabbix@localhost identified by '45Yn9aURSI6j';" 
sudo mysql -uroot -e "FLUSH PRIVILEGES;"
sudo mysql -uroot -e "quit"

sudo zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz | sudo mysql -uzabbix zabbix -p45Yn9aURSI6j

sudo git clone https://github.com/airmeno/zabbix.git ~/zabbix

sudo cp ~/zabbix/zabconf/zabbix_server.conf /etc/zabbix
sudo cp ~/zabbix/zabconf/nginx.conf /etc/zabbix
sudo cp ~/zabbix/zabconf/php-fpm.conf /etc/zabbix

sudo systemctl restart zabbix-server zabbix-agent nginx php7.4-fpm
sudo systemctl enable zabbix-server zabbix-agent nginx php7.4-fpm
