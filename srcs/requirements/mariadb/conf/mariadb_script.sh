#!/usr/bin/env bash

# Start MariaDB
service mysql start;

# create database (if does not exist)
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# create user and password (if does not exist)
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

# give all privileges to the user on the database
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# modify sql database
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# flush privileges
mysql -e "FLUSH PRIVILEGES;"

# shutdown
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# use exec 
exec mysqld_safe


