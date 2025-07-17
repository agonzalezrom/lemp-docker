FROM php:8.4-fpm-alpine

# Install system dependencies
RUN apk add --no-cache \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libzip-dev \
    oniguruma-dev \
    gmp-dev \
    imagemagick-dev \
    imagemagick \
    pkgconfig \
    git \
    curl \
    unzip \
    exiftool \
    icu-dev \
    autoconf \
    g++ \
    make \
    linux-headers

# Configure and install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        gd \
        pdo_mysql \
        mysqli \
        zip \
        exif \
        intl \
        gmp \
        opcache \
    && pecl install imagick xdebug \
    && docker-php-ext-enable imagick xdebug

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

# Create user and group
RUN addgroup -g 1000 www && \
    adduser -u 1000 -G www -s /bin/sh -D www

# Set working directory
WORKDIR /var/www/html

# Copy project files (excluding what's in .dockerignore)
COPY --chown=www:www . .

# Switch to non-root user
USER www

# Expose port 9000
EXPOSE 9000

# Start php-fpm
CMD ["php-fpm"]
