sudo apt-get install mysql-client mysql-server -y
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql
sudo debconf-set-selections <<< 'mysql-server mysql-server/ password wordpress'
sudo mysql <<EOF
CREATE DATABASE wordpress;
CREATE USER 'wordpress'@'$IP_PRIVATE_WEB' IDENTIFIED BY 'wordpress';
GRANT ALL PRIVILEGES on wordpress.* TO 'wordpress'@'IP_PRIVATE_WEB' IDENTIFIED BY 'wordpress';
GRANT ALL PRIVILEGES on *.* TO 'root'@'IP_PRIVATE_WEB' IDENTIFIED BY 'wordpress';
FLUSH PRIVILEGES;
\q;
EOF
sudo systemctl restart mysql
