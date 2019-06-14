apt-get install mysql-server -y 
debconf-set-selections <<< 'mysql-server mysql-server/ password wordpress' 

#abilitando o BD para escutar todos o ips podese colocar o ip do serv web ou so comenta

sed -i "/bind-address/d" /etc/mysql/mysql.conf.d/mysqld.cnf
systemctl restart mysql.service
mysql <<EOF
CREATE DATABASE wordpress;
GRANT ALL ON wordpress.* TO 'wordpress'@'$IP_PRIVATE_WEB' IDENTIFIED BY 'wordpress' WITH GRANT OPTION;
FLUSH PRIVILEGES;
\q;
EOF
