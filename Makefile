# COLORS
GREEN		= \033[1;32m
RED 		= \033[1;31m
ORANGE		= \033[1;33m
CYAN		= \033[1;36m
RESET		= \033[0m

# FOLDER
SRCS_DIR	= ./
DOCKER_DIR	= ${SRCS_DIR}docker-compose.yml
NAME		= $(shell cat ${SRCS_DIR}.env | grep PROJECT_NAME | cut -d '=' -f2)


# VARIABLES
ENV_FILE	= ${SRCS_DIR}.env

# COMMANDS
DOCKER		=  docker compose -f ${DOCKER_DIR} --env-file ${ENV_FILE} -p ${NAME}

%:
	@:

all: up

up:
	@echo "${GREEN}Create hostnames...${RESET}"
	@chmod +x ./srcs/tools/host.sh
	@./srcs/tools/host.sh
	@echo "${GREEN}Building containers...${RESET}"
	@${DOCKER} up -d

build:
	@echo "${GREEN}Building containers...${RESET}"
	@${DOCKER} up -d --build

down:
	@echo "${GREEN}Stopping containers...${RESET}"
	@${DOCKER} down

stop:
	@echo "${GREEN}Stopping containers...${RESET}"
	@${DOCKER} stop

start:
	@echo "${GREEN}Starting containers...${RESET}"
	@${DOCKER} start

restart:
	@echo "${GREEN}Restarting containers...${RESET}"
	@${DOCKER} restart

logs:
	@echo "${GREEN}Displaying logs...${RESET}"
	@${DOCKER} logs -f

rebuild: down delete
	@echo "${GREEN}Create hostnames...${RESET}"
	@chmod +x ./srcs/tools/host.sh
	@./srcs/tools/host.sh
	@echo "${GREEN}Rebuilding containers...${RESET}"
	@${DOCKER} up -d --build --force-recreate

delete:
	@echo "${GREEN}Deleting containers...${RESET}"
	@${DOCKER} down --volumes --remove-orphans

node:
	@echo "${GREEN}Running nodejs...${RESET}"
	@${DOCKER} exec nodejs bash

wordpress:
	@echo "${GREEN}Running wordpress...${RESET}"
	@${DOCKER} exec wordpress bash

# run production : npm run production inside container nodejs
production:
	@echo "${GREEN}Compiling Toolkit for production...${RESET}"
	@${DOCKER} exec nodejs npm run production

npm:
	@echo "${GREEN}Running npm...${RESET}"
	@${DOCKER} exec nodejs npm $(filter-out $@,$(MAKECMDGOALS))

# git commands : make git [command] [arg] 
git:
	@echo "${GREEN}Running git command...${RESET}"
	@chmod +x ./srcs/tools/git.sh
	@./srcs/tools/git.sh $(filter-out $@,$(MAKECMDGOALS))
	

help:
	@echo "\n\033[1mUsage: make [target]${RESET}\n"
	@echo "\033[1mTargets:${RESET}"
	@echo "\033[1m  up${RESET}            - Build and start containers"
	@echo "\033[1m  down${RESET}          - Stop and remove containers"
	@echo "\033[1m  stop${RESET}          - Stop containers"
	@echo "\033[1m  start${RESET}         - Start containers"
	@echo "\033[1m  restart${RESET}       - Restart containers"
	@echo "\033[1m  logs${RESET}          - Display logs"
	@echo "\033[1m  rebuild${RESET}       - Rebuild containers"
	@echo "\033[1m  delete${RESET}        - Delete containers"
	@echo "\033[1m  production${RESET}    - Compile Toolkit for production"
	@echo "\033[1m  git${RESET}           - Git commands"
	@echo "\033[1m  help${RESET}          - Display this help"

.PHONY: all up build down stop start restart logs rebuild delete help git production