# Zabbix 5 LTS installation script 

Server configuration:
Linux Ubuntu 20
MySQL (MariaDB)
NGINX

---

Start Installation Script: 

sudo sh zabbix-install.sh

---

MySQL (MariaDB) zabbix user password. Replace with your password.
This password must be changed in the file /etc/zabbix/zabbix_server.conf for the parameter DBPassword=your_password.

---
Edit file /etc/zabbix/nginx.conf:

server_name example.com;

---
Edit file /etc/zabbix/php-fpm.conf: (replace with your region)

php_value[date.timezone] = Europe/Moscow

---

Connect to your newly installed Zabbix frontend: http://server_ip_or_name
