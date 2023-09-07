FROM php:8-fpm

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        zlib1g-dev \
        libxml2-dev \
        libzip-dev \
        libonig-dev \
        librabbitmq-dev \
        graphviz \
        vim \
        git \
        curl \
        unzip \
        exiftool \
        imagemagick \
        libmagickwand-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Imagick

RUN pecl install imagick && \
    docker-php-ext-enable imagick

# Install extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install zip \
    && docker-php-source delete \
    && docker-php-ext-configure exif \
    && docker-php-ext-install exif \
    && docker-php-ext-enable exif \
    && docker-php-ext-install intl \
    && docker-php-ext-enable intl

RUN pecl install xdebug \
    && docker-php-ext-enable --ini-name 05-opcache.ini opcache xdebug

# Install Composer
RUN curl --silent --show-error https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Copy the files
COPY . /var/www/html

# Set working directory
WORKDIR /var/www/html

# Add user for laravel/symfony application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory permissions
COPY --chown=www:www . /var/www/html

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]