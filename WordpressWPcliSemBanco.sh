echo "Instalação wordpress em andamento, aguarde..."
IP_Public="$(curl http://169.254.169.254/latest/meta-data/public-ipv4)" 
sudo apt-get update 
sudo apt-get install apache2 apache2-utils -y 
sudo systemctl enable apache2 
sudo systemctl start apache2  
sudo apt-get install mysql-client -y
sudo apt-get install php7.2 php7.2-mysql libapache2-mod-php7.2 php7.2-cli php7.2-cgi php7.2-gd -y
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
sudo -u ubuntu -i -- wp core download --locale=pt_BR
sudo -u ubuntu -i -- wp core config --dbname=wordpress --dbuser=wordpress --dbpass=wordpress --dbhost='$IPBANCOPRIVADO' --dbprefix=word
sudo -u ubuntu -i -- wp core install --url="http://$IP_Public" --title="Topicos Avancados" --admin_user='$USUARIOWORDPRESS' --admin_password='$SENHAWORDPRESS' --admin_email="topicos@gmail.com"
sudo mv * /var/www/html/
sudo rm -fr /var/www/html/index.html
sudo systemctl restart apache2
