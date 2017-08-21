#!/bin/sh
if [ ! -e /var/www/localhost/htdocs/shopware.php ]
then
	cp /opt/index.php /var/www/localhost/htdocs/index.php
fi
chown apache:apache /var/www/localhost/htdocs
exec httpd -D FOREGROUND