ENV_FILE		:= srcs/.env
COMPOSE_FILE	:= srcs/docker-compose.yml

.PHONY: all
all: start

.PHONY: start
start:
	@if [ ! -e $(ENV_FILE) ]; then \
		echo "Error: env file not found"; \
		exit 1; \
	fi
	docker compose -f $(COMPOSE_FILE) up -d --build 

.PHONY: stop
stop:
	docker compose -f $(COMPOSE_FILE) down

.PHONY: clean
clean: stop
	docker image rm inception-nginx:1.0

.PHONY: re
re: stop clean all

.PHONY: logs
logs:
	docker compose -f $(COMPOSE_FILE) logs --follow
	