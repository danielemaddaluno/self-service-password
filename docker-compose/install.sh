CONFIG=conf/config.inc.php
if [ ! -f $CONFIG ]; then
   echo "Downloading $CONFIG"
   mkdir conf
   curl -s -L -o $CONFIG https://raw.githubusercontent.com/danielemaddaluno/self-service-password/master/assets/config.inc.php
fi
docker-compose up