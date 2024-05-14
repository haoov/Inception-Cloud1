PROJDIR		=	$(realpath $(CURDIR))
SRCS		=	$(CURDIR)/srcs

SUDO		=	/usr/bin/sudo

all :

build :
	@cd $(SRCS) && $(SUDO) docker-compose build

run :
	@cd $(SRCS) && $(SUDO) docker-compose up -d

stop :
	@cd $(SRCS) && $(SUDO) docker-compose stop

fclean :
	@cd $(SRCS) && $(SUDO) docker-compose down -v
	@$(SUDO) docker system prune -f
	@$(SUDO) rm -rf ~/data/mariadb/* ~/data/portainer/* ~/data/wordpress/*

.PHONY : build run fclean
