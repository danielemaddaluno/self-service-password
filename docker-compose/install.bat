@echo off
set CONFIG=conf/config.inc.php

set /p port=Insert the port number for self-service-password:
(
echo version: "3"
echo services:
echo   ssp:
echo     image: danielemaddaluno/self-service-password
echo     ports:
echo      - %port%:80
echo     volumes:
echo      - ./conf/:/var/www/html/conf/
)>"docker-compose.yaml"

if not exist %CONFIG% (
	echo Downloading %CONFIG%
	mkdir conf
	curl -s -L -o %CONFIG% https://raw.githubusercontent.com/danielemaddaluno/self-service-password/master/assets/config.inc.php
)
echo docker-compose up
docker-compose up


