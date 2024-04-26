all:
	if ! grep -q "druina.42.fr" /etc/hosts; then \
		echo "127.0.0.1 druina.42.fr" >> /etc/hosts; \
	fi
	if ! grep -q "www.druina.42.fr" /etc/hosts; then \
		echo "127.0.0.1 www.druina.42.fr" >> /etc/hosts; \
	fi
	mkdir -p /home/druina/data/mariadb-data
	mkdir -p /home/druina/data/wordpress-data
	docker-compose -f srcs/docker-compose.yml build
	docker-compose -f srcs/docker-compose.yml up -d
	
clean:
	docker-compose -f srcs/docker-compose.yml down --rmi all -v

fclean: clean
	rm -rf /home/druina/data/mariadb-data
	rm -rf /home/druina/data/wordpress-data
	docker system prune -f

re: fclean all

up:
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

.PHONY: all clean fclean re up down