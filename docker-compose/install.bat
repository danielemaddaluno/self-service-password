@echo off
set CONFIG=conf/config.inc.php

if not exist %CONFIG% (
	echo Downloading %CONFIG%
	mkdir conf
	curl -s -L -o %CONFIG% https://raw.githubusercontent.com/danielemaddaluno/self-service-password/master/assets/config.inc.php
)
echo docker-compose up
docker-compose up