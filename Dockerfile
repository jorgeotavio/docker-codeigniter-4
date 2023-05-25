FROM php:8.2.4-apache

RUN apt-get update && \
    apt-get install -y \
        libicu-dev \
        libonig-dev \
        libzip-dev \
        unzip

RUN docker-php-ext-install \
    intl \
    mbstring \
    pdo \
    mysqli \
    pdo_mysql \
    zip

RUN a2enmod rewrite

COPY . /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY composer.* /var/www/html/

RUN composer install --no-autoloader

COPY . /var/www/html/

EXPOSE 80

CMD ["apache2-foreground"]
