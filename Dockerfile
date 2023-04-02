# Usando uma imagem do PHP 8.2 como base
FROM php:8.2.4-apache

# Instalando as dependências necessárias
RUN apt-get update && \
    apt-get install -y \
        libicu-dev \
        libonig-dev \
        libzip-dev \
        unzip

# Habilitando extensões do PHP
RUN docker-php-ext-install \
    intl \
    mbstring \
    pdo \
    mysqli \
    pdo_mysql \
    zip

# Habilitando o modo de reescrita do Apache
RUN a2enmod rewrite

# Copiando os arquivos do projeto para o diretório do Apache
COPY . /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY composer.json /var/www/html/

# Expondo a porta 80 para acesso do navegador
EXPOSE 80

# Iniciando o servidor Apache
CMD ["apache2-foreground"]
