FROM alpine:latest

RUN apk update
RUN apk upgrade

# Dependencies for build
RUN apk add curl php7-apache2
RUN mkdir /run/apache2

# Dependencies to start the install wizard
RUN apk add php7-curl php7-zip php7-json php7-session php7-mbstring php7-simplexml

# Dependencies checked by install wizard
RUN apk add php7-gd php7-pdo php7-openssl php7-iconv php7-xml php7-ftp

# Additionally needed dependencies
RUN apk add php7-pdo_mysql php7-ctype php7-dom php7-tokenizer php7-fileinfo

# Dependencies for performance
RUN apk add php7-opcache php7-apcu php7-zlib

# Fix iconv on alpine (https://github.com/docker-library/php/issues/240#issuecomment-305038173)
RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

# Startup file that copies the shopware installer to the mount and ensures proper permissions
COPY startup.sh /opt/startup.sh

# Apache config that enabled mod_rewrite and redirected the error log
COPY apache.conf /etc/apache2/conf.d/99shopware.conf

# Fake HTTPs for SSL offloading by reverse proxy
COPY auto_prepend.php /opt/auto_prepend.php
RUN echo "auto_prepend_file = \"/opt/auto_prepend.php\"" > /etc/php7/conf.d/auto_prepend.ini

# Shopware installer
RUN curl https://s3-eu-west-1.amazonaws.com/releases.s3.shopware.com/Downloader/index.php > /opt/index.php

EXPOSE 80
CMD /opt/startup.sh
