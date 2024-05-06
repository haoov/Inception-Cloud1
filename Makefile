PROJDIR		=	$(realpath $(CURDIR))
SRCS		=	$(CURDIR)/srcs

all :

build :
	@cd $(SRCS) && docker compose build

run :
	@cd $(SRCS) && docker compose up -d

stop :
	@cd $(SRCS) && docker compose stop

fclean :
	@cd $(SRCS) && docker compose down -v
	@docker system prune -f
	@rm -rf ~/data/mariadb/* ~/data/portainer/* ~/data/wordpress/*

.PHONY : build run fclean
