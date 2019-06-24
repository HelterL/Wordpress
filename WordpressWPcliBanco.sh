sudo apt-get install mysql-server -y
sudo debconf-set-selections <<< 'mysql-server mysql-server/ password wordpress'
sed -i "/bind-address/d" /etc/mysql/mysql.conf.d/mysqld.cnf
systemctl restart mysql.service
sudo mysql <<EOF
CREATE DATABASE wordpress;
GRANT ALL ON wordpress.* TO 'wordpress'@'%' IDENTIFIED BY 'wordpress' WITH GRANT OPTION;
FLUSH PRIVILEGES;
\q;
EOF
