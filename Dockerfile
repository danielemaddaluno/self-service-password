FROM alpine:3.12.4
LABEL Maintainer="Daniele Maddaluno <daniele.maddaluno@gmail.com>" \
      Description="Lightweight container ltb-project"

EXPOSE 80

RUN apk --no-cache add \
    php7 \
    php7-fpm \
    php7-xml \
    php7-mbstring \
    php7-mcrypt \
    php7-ldap \
    php7-session \
    php7-iconv \
    nginx \
    supervisor \
    curl \
    ca-certificates

# Configure nginx
COPY assets/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY assets/fpm-pool.conf /etc/php7/php-fpm.d/z_custom_fpm-pool.conf
COPY assets/php.ini /etc/php7/conf.d/z_custom_php.ini

# Configure supervisord
COPY assets/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV LTB_PROJECT_VERSION 1.3
# Computed on MacOS with "shasum -a 256 self-service-password.tar.gz"
ENV LTB_PROJECT_SHA256 e528e879c4f14cb13f0ea947b5205de7e555f55c14ca8d5533e81ef48d47c8a9

# Download ltb-project self-service password
RUN curl -s -L -o self-service-password.tar.gz https://github.com/ltb-project/self-service-password/archive/v1.3.tar.gz && \
    echo "${LTB_PROJECT_SHA256}  self-service-password.tar.gz" | sha256sum -c '-'

# Install ltb-project
RUN mkdir -p /var/www/html && \
    tar zxf self-service-password.tar.gz --strip 1 -C /var/www/html && \
    rm self-service-password.tar.gz

# add default config file
COPY assets/config.inc.php /var/www/html/conf/config.inc.php

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
