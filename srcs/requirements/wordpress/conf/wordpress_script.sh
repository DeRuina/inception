#!/bin/sh

attempts=0
while ! mariadb -h$MYSQL_HOST -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD $WORDPRESS_DB_NAME &>/dev/null; do
	attempts=$((attempts + 1))
    echo "MariaDB unavailable. Attempt $attempts: Trying again in 5 sec."
	if [ $attempts -ge 12 ]; then
		echo "Max attempts reached. MariaDB connection could not be established."
        exit 1
	fi
    sleep 5
done
echo "MariaDB connection established!"

echo "Listing databases:"
mariadb -h$MYSQL_HOST -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD $WORDPRESS_DB_NAME <<EOF
SHOW DATABASES;
EOF


cd /var/www/html/wordpress/


wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp


chmod +x /usr/local/bin/wp


wp core download --allow-root


wp config create \
	--dbname=$WORDPRESS_DB_NAME \
	--dbuser=$WORDPRESS_DB_USER \
	--dbpass=$WORDPRESS_DB_PASSWORD \
	--dbhost=$MYSQL_HOST \
	--path=/var/www/html/wordpress/ \
	--force


wp core install \
	--url=$DOMAIN_NAME \
	--title=$WORDPRESS_TITLE \
	--admin_user=$WORDPRESS_ADMIN_USER \
	--admin_password=$WORDPRESS_ADMIN_PASSWORD \
	--admin_email=$WORDPRESS_ADMIN_EMAIL \
	--allow-root \
	--skip-email \
	--path=/var/www/html/wordpress/


wp user create \
	$WORDPRESS_USER \
	$WORDPRESS_EMAIL \
	--role=author \
	--user_pass=$WORDPRESS_PASSWORD \
	--allow-root


wp theme install neve  \
	--activate \
	--allow-root


wp plugin update --all


wp option update siteurl "https://$DOMAIN_NAME" --allow-root
wp option update home "https://$DOMAIN_NAME" --allow-root


chown -R nginx:nginx /var/www/html/wordpress


chmod -R 755 /var/www/html/wordpress


php-fpm81 -F