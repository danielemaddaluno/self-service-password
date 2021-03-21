@echo off
echo Insert the name of the folder which will contain the docker-compose.yaml:
set /p FOLDER=
mkdir %FOLDER%
cd %FOLDER%

echo Insert the port number for self-service-password:
set /p PORT=
(
echo version: "3"
echo services:
echo   ssp:
echo     image: danielemaddaluno/self-service-password
echo     ports:
echo      - %PORT%:80
echo     volumes:
echo      - ./conf/:/var/www/html/conf/
)>"docker-compose.yaml"

set CONFIG=conf/config.inc.php
if not exist %CONFIG% (
	echo Downloading config.inc.php inside conf folder
	mkdir conf
	curl -s -L -o %CONFIG% https://raw.githubusercontent.com/danielemaddaluno/self-service-password/master/assets/config.inc.php
)

echo docker-compose up
docker-compose up