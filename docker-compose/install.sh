#!/bin/bash
echo "Insert the name of the folder which will contain the docker-compose.yaml:"
read FOLDER
mkdir $FOLDER
cd $FOLDER

echo "Insert the port number for self-service-password:"
read PORT
{
echo "version: \"3\""
echo "services:"
echo "  ssp:"
echo "    image: danielemaddaluno/self-service-password"
echo "    ports:"
echo "     - $PORT:80"
echo "    volumes:"
echo "     - ./conf/:/var/www/html/conf/"
} > "docker-compose.yaml"

CONFIG=conf/config.inc.php
if [ ! -f $CONFIG ]; then
   echo "Downloading config.inc.php inside conf folder"
   mkdir conf
   curl -s -L -o $CONFIG https://raw.githubusercontent.com/danielemaddaluno/self-service-password/master/assets/config.inc.php
fi

docker-compose up