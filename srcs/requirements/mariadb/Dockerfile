FROM debian:buster

# install the program
RUN apt update && apt upgrade -y && apt install -y mariadb-server

# mariadb config
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

# copy the script
COPY conf/mariadb_script.sh /mariadb_script.sh

# execute the script
ENTRYPOINT ["bash", "mariadb_script.sh"]

# expose the only port allowed (MySQL)
EXPOSE 3306