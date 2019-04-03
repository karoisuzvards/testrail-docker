FROM php:7.2.16-apache-stretch

RUN apt-get update && apt-get install -y \
     unzip \
     cron \
     supervisor

RUN docker-php-ext-install mysqli

RUN mkdir /ioncube && \
    curl -O https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz && \
    tar vxfz ioncube_loaders_lin_*.tar.gz -C / && \
    rm -f ioncube_loaders_lin_*.tar.gz

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN echo "zend_extension=/ioncube/ioncube_loader_lin_7.2.so" >> $PHP_INI_DIR/php.ini

COPY testrail-*.zip /
RUN cd /var/www/html && unzip -q /testrail-*.zip

COPY config.php /var/www/html/testrail/config.php

RUN mkdir /var/www/html/testrail/logs && \
chown www-data /var/www/html/testrail/logs

RUN echo '* * * * * www-data php /var/www/html/testrail/task.php' >> /etc/crontab

EXPOSE 80

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENTRYPOINT ["/usr/bin/supervisord"]