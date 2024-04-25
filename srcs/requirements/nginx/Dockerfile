FROM debian:buster

# install the program
RUN apt update && apt upgrade -y && apt install -y nginx

# nginx SSL
RUN mkdir -p /etc/nginx/ssl && apt install openssl -y
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=druina.42.fr/UID=druina"

# nginx config
RUN mkdir -p /var/run/nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Start nginx
CMD [ "nginx", "-g", "daemon off;" ]

