FROM debian:buster

# install wget to download wordpress
RUN apt update && apt upgrade -y && apt install -y wget 

# install php and dependencies
RUN apt install -y php7.3 php-fpm php-mysql mariadb-client

# download wordpress and extract it
RUN wget https://wordpress.org/wordpress-6.0.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.0.tar.gz && rm wordpress-6.0.tar.gz

# copy the config file
COPY conf/php.conf /etc/php/7.3/fpm/pool.d/www.conf

# give user rights to write in the dir
RUN		chown -R root:root /var/www/wordpress

# install wp-cli to manage wordpress installation
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# copy wp-cli to /usr/local/bin/wp and give the right to the user to write in the directory
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# copy the script
COPY conf/wordpress_script.sh wordpress_script.sh

# run
ENTRYPOINT  ["bash", "wordpress_script.sh"]

