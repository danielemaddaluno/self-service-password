#!/bin/bash
echo "Insert the port number for self-service-password:"
read port

{
echo "version: \"3\""
echo "services:"
echo "  ssp:"
echo "    image: danielemaddaluno/self-service-password"
echo "    ports:"
echo "     - $port:80"
echo "    volumes:"
echo "     - ./conf/:/var/www/html/conf/"
} > "docker-compose.yaml"

CONFIG=conf/config.inc.php
if [ ! -f $CONFIG ]; then
   echo "Downloading $CONFIG"
   mkdir conf
   curl -s -L -o $CONFIG https://raw.githubusercontent.com/danielemaddaluno/self-service-password/master/assets/config.inc.php
fi
docker-compose up