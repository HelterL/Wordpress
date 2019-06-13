#!/bin/bash
IP_PUBLIC=`curl -s http://169.254.169.254/latest/meta-data/public-ipv4`
echo "Instalação wordpress em andamento, aguarde..."
sudo apt-get update 
sudo apt-get install apache2 apache2-utils -y 
sudo systemctl enable apache2 
sudo systemctl start apache2  
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
sudo sed -i '10s/^/        ServerName '$IP_PUBLIC'/' /etc/apache2/sites-available/000-default.conf
sudo sed -i '12s/html/wordpress/' /etc/apache2/sites-available/000-default.conf
sudo sed -i '13s/^/        ServerAlias www.hlrp.com/' /etc/apache2/sites-available/000-default.conf
sudo a2ensite wordpress.conf
sudo service apache2 restart
sudo touch /var/www/html/.htaccess
sudo chown :www-data /var/www/html/.htaccess
sudo chmod 664 /var/www/html/.htaccess
sudo service apache2 restart
echo "No browser coloque seu ip publico"
echo -e "Usuário: wordpress\nSenha: wordpress\n"
