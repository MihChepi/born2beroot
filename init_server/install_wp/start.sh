#start_server
#
#
#
#nginx
#rm -f /etc/nginx/sites-enabled/default
#rm -f /etc/nginx/sites-available/default
#cp nginx.conf /etc/nginx/sites-available/nginx.conf
#ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf

#lighttpd
lighttpd-enable-mod fastcgi
lighttpd-enable-mod accesslog
lighttpd-enable-mod cgi
cp lighttpd.conf /etc/lighttpd/ 

#wordpress
cp -r wordpress/* /var/www/html/
cp wp-config.php /var/www/html/wordpress
#chown ?

#phpmyadmin
cp -r phpMyAdmin-4.9.5-english  /usr/share/phpmyadmin
cp config.inc.php /usr/share/phpmyadmin
ln -s /usr/share/phpmyadmin /var/www/html/
chown -R www-data:www-data /usr/share/phpmyadmin

#start services
service lighttpd start
service php7.4-fpm start
service mysql start

#crate database
echo "CREATE DATABASE wordpress;"| mysql 
echo "CREATE USER admin@localhost IDENTIFIED BY 'admin';"| mysql
echo "GRANT ALL PRIVILEGES ON *.* TO admin@localhost;"| mysql
echo "FLUSH PRIVILEGES;"| mysql

