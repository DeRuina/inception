FROM debian:buster

# install the program
RUN apt update && apt upgrade -y && apt install -y mariadb-server

# mariadb config
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf