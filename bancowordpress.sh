sudo apt-get install mysql-client mysql-server -y
sudo debconf-set-selections <<< 'mysql-server mysql-server/ password wordpress'
sudo mysql <<EOF
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES on wordpress.* TO 'wordpress'@'localhost' IDENTIFIED BY 'wordpress';
FLUSH PRIVILEGES;
\q;
EOF
sudo systemctl restart mysql
