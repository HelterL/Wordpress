#!/bin/bash
sudo apt-get install mysql-server -y
sudo sed -i '43s/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo service mysql restart
sudo debconf-set-selections <<< 'mysql-server mysql-server/ password wordpress'
sudo mysql <<EOF
CREATE DATABASE wordpress;
CREATE USER `wordpress`@`$IP_PRIVATE_WEB` IDENTIFIED BY 'wordpress';
GRANT ALL ON wordpress.* TO `wordpress`@`$IP_PRIVATE_WEB`;
GRANT ALL ON *.* TO 'wordpress'@'$IP_PRIVATE_WEB' IDENTIFIED BY 'wordpress' WITH GRANT OPTION;
FLUSH PRIVILEGES;
\q;
EOF
sudo systemctl restart mysql.service
