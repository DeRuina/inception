FROM alpine:3.18

# user nginx and add to groups (create if it doesn't exist)
RUN addgroup -S nginx && adduser -S -G nginx -g nginx nginx

# Install php and php-fpm
RUN apk update && apk add --no-cache php81 php81-fpm php81-cgi php81-phar php81-json php81-mysqli php81-curl php81-iconv curl wget composer bash mariadb-client

# Listening port
EXPOSE 9000

# Create and copy paths and confs to cont
RUN mkdir -p /run/php/ /var/www/html/wordpress/
COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

# Copy wordpress script
COPY conf/wordpress_script.sh /
RUN chmod +x wordpress_script.sh

# Run wordpress script
ENTRYPOINT ["sh", "/wordpress_script.sh"]