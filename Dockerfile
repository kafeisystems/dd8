# from https://www.drupal.org/requirements/php#drupalversions
FROM php:7.4-apache-buster

RUN a2enmod rewrite

# install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libpq-dev default-mysql-client libonig-dev libzip-dev \
        && rm -rf /var/lib/apt/lists/* \
        #&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
        && docker-php-ext-install gd mbstring opcache pdo pdo_mysql pdo_pgsql zip

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
                echo 'opcache.memory_consumption=128'; \
                echo 'opcache.interned_strings_buffer=8'; \
                echo 'opcache.max_accelerated_files=4000'; \
                echo 'opcache.revalidate_freq=60'; \
                echo 'opcache.fast_shutdown=1'; \
                echo 'opcache.enable_cli=1'; \
        } > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN { echo 'memory_limit=356M'; } > /usr/local/etc/php/php.ini
RUN { echo 'max_execution_time=125'; } > /usr/local/etc/php/php.ini

WORKDIR /var/www/html

# https://github.com/drush-ops/drush/releases
RUN curl https://github.com/drush-ops/drush/releases/download/8.4.6/drush.phar -L -o drush.phar
RUN php drush.phar core-status
RUN chmod +x drush.phar
RUN mv drush.phar /usr/local/bin/drush
