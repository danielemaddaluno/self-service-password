# LDAP Tool Box Self Service Password with Docker

A lightweight Self Service Password Docker image built from source atop [Alpine Linux](https://store.docker.com/images/alpine).

Self Service Password is a PHP application that allows users to change their password in an LDAP directory. See http://ltb-project.org/wiki/documentation/self-service-password.<br>
The application can be used on standard LDAPv3 directories (OpenLDAP, OpenDS, ApacheDS, Sun Oracle DSEE, Novell, etc.) and also on Active Directory.

## How to use this image

The easiest way is to create your own configuration file and modify it according to your settings. Download the latest version of the `config.inc.php` file from https://github.com/ltb-project/self-service-password/tree/master/conf/config.inc.php.

```
$ docker run -d \
         -p 8080:80 \
         -v config.inc.php:/var/www/html/conf/config.inc.php \
         --name ssp \
         danielemaddaluno/self-service-password:latest
```

For docker-compose use this snippet:
```
version: "3"
services:
  ssp:
      image: danielemaddaluno/self-service-password
      ports:
        - 8080:80
      volumes:
        - ./conf:/var/www/html/conf/
```
Inside the github [docker-compose](https://github.com/danielemaddaluno/self-service-password/tree/master/docker-compose) folder you can find a `.yaml` example file and bat/sh scripts to automatically startup `self-service-password` with docker-compose.

## Modify the image

You can build your own Image with your `config.inc.php` settings:

```
FROM danielemaddaluno/self-service-password
COPY config.inc.php:/var/www/html/conf/config.inc.php
```

## Building the image yourself

```
git clone https://github.com/danielemaddaluno/self-service-password.git
cd self-service-password
docker build -t self-service-password .
```

Don't forget to edit the configuration file `assets/config.inc.php`


## Disable all certificate validation
If you need to disable all certificate validation just uncomment the following line `putenv('LDAPTLS_REQCERT=never');` inside of the configuration file `config.inc.php`


## Documentation for LTB Self-Service-Password

Documentation is available on http://ltb-project.org/wiki/documentation/self-service-password