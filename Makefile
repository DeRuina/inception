YML_PATH = srcs/docker-compose.yml


.PHONY: up down ps clean fclean prune re all reset info

all:
	if ! grep -q "druina.42.fr" /etc/hosts; then \
		echo "127.0.0.1 druina.42.fr" >> /etc/hosts; \
	fi
	if ! grep -q "www.druina.42.fr" /etc/hosts; then \
		echo "127.0.0.1 www.druina.42.fr" >> /etc/hosts; \
	fi
	mkdir -p /home/druina/data/mariadb-data
	mkdir -p /home/druina/data/wordpress-data
	docker compose -f $(YML_PATH) up -d

up:
	docker compose -f $(YML_PATH) up -d

down:
	docker compose -f $(YML_PATH) down

ps:
	docker compose -f $(YML_PATH) ps

clean:
	docker compose -f $(YML_PATH) down --rmi all -v

fclean: clean
	@if [ -d $(FILES_PATH) ]; then \
		sudo rm -rf $(FILES_PATH); \
	fi;

prune:
	docker system prune --all --force --volumes

re: fclean all

rm_all:
	docker stop $$(docker ps -aq);
	docker rm $$(docker ps -qa);
	docker rmi -f $$(docker images -qa);
	docker volume rm $$(docker volume ls -q);
	