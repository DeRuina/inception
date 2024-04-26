FROM alpine:3.18

# Install mariadb
RUN apk update && apk add --no-cache mariadb mariadb-client

# Expose port 3306
EXPOSE 3306

# Copy mariadb conf
COPY conf/mariadb.cnf /etc/my.cnf.d/mariadb.cnf
RUN chmod 644 /etc/my.cnf.d/mariadb.cnf

# Copy mariadb script
COPY conf/mariadb_script.sh /tmp/mariadb_script.sh
RUN chmod +x /tmp/mariadb_script.sh

# Run mariadb script
ENTRYPOINT ["sh", "/tmp/mariadb_script.sh"]