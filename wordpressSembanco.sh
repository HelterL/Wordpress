echo "Instalação wordpress em andamento, aguarde..."
sudo apt-get update 
sudo apt-get install apache2 apache2-utils -y 
sudo systemctl enable apache2 
sudo systemctl start apache2  
sudo apt-get install mysql-client -y
sudo apt-get install php7.2 php7.2-mysql libapache2-mod-php7.2 php7.2-cli php7.2-cgi php7.2-gd -y
cd /tmp
wget -c http://wordpress.org/latest.tar.gz
sudo tar -xzvf latest.tar.gz
sudo rsync -av wordpress/* /var/www/html/
sudo chmod -R 755 /var/www/html/
cd /var/www/html
sudo mv wp-config-sample.php wp-config.php
sudo sed -i 's/database_name_here/wordpress/g' wp-config.php
sudo sed -i 's/username_here/wordpress/g' wp-config.php
sudo sed -i 's/password_here/wordpress/g' wp-config.php
sudo systemctl restart apache2.service
sudo rm -rf /var/www/html/index.html
sudo sed -i '/warn/a <Directory /var/www/html/>\n   AllowOverride All\n</Directory>' /etc/apache2/sites-available/000-default.conf
sudo a2enmod rewrite
sudo service apache2 restart
sudo touch /var/www/html/.htaccess
sudo chown :www-data /var/www/html/.htaccess
sudo chmod 664 /var/www/html/.htaccess
sudo service apache2 restart
