sudo apt-get install mysql-client mysql-server -y
sudo debconf-set-selections <<< 'mysql-server mysql-server/ password wordpress'
sudo apt-get install php7.2 php7.2-mysql libapache2-mod-php7.2 php7.2-cli php7.2-cgi php7.2-gd -y
sudo mysql <<EOF
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES on wordpress.* TO 'wordpress'@'%' IDENTIFIED BY 'wordpress';
FLUSH PRIVILEGES;
\q;
EOF
