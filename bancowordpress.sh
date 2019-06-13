
#!/bin/bash
sudo apt-get install mysql-client mysql-server -y
sudo sed -i '43s/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo service mysql restart
sudo debconf-set-selections <<< 'mysql-server mysql-server/ password wordpress'
sudo mysql <<EOF
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES on wordpress.* TO 'wordpress'@'$IP_PRIVATE_WEB' IDENTIFIED BY 'wordpress';
FLUSH PRIVILEGES;
\q;
EOF
sudo systemctl restart mysql.service
