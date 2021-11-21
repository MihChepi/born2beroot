# server
# nginx + wordpress + phpyadmin 
# + ssl key

apt install -y vim
apt install -y wget tar
apt install -y mariadb-server

#lighttpd
apt install -y lighttpd

#wordpress
wget https://ru.wordpress.org/latest-ru_RU.tar.gz
tar -xzvf latest-ru_RU.tar.gz
rm -rf latest-ru_RU.tar.gz	

#phpmtadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.5/phpMyAdmin-4.9.5-english.tar.gz
tar -xzvf phpMyAdmin-4.9.5-english.tar.gz && rm -rf phpMyAdmin-4.9.5-english.tar.gz 
apt install -y php7.4 php7.4-fpm php7.4-mysql php7.4-curl php7.4-gd php7.4-intl php7.4-mbstring php7.4-soap php7.4-xml php7.4-xmlrpc php7.4-zip php7.4-common php7.4-gmp php7.4-cli php7.4-imap php-cgi php-xmlrpc php-pear
	
#SSL key
apt install -y  openssl

ufw allow 80
