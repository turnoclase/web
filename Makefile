help: _header
	${info }
	@echo Opciones:
	@echo --------------------
	@echo build
	@echo workspace
	@echo update / serve
	@echo deploy
	@echo clean
	@echo --------------------

_header:
	@echo --------------------
	@echo TurnoClase - Website
	@echo --------------------

build:
	@docker compose build --pull

workspace:
	@docker compose run -q --rm node /bin/bash

update:
	@docker compose run -q --rm node /bin/bash -c 'source /home/node/.bashrc && cd jekyll && bundle update --all'
	@echo Generando commit...
	@sleep 5
	@git commit -a -m "Actualización de dependencias"

deploy:
	@cd jekyll && bundle exec jekyll build
	@cd ..
	@docker compose run -q --rm --service-ports node /bin/sh -c 'firebase login && firebase use turnoclase-eu && firebase deploy --only hosting'

serve:
	@cd jekyll && bundle exec jekyll serve

clean:
	@docker compose down -v --remove-orphans
