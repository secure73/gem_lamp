# Use PHP 8.2 with Apache as the base image
FROM php:8.2-apache

# Install necessary PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Install Composer
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget -O /usr/local/bin/composer https://getcomposer.org/composer-stable.phar && \
    chmod +x /usr/local/bin/composer

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Create a directory for the application
RUN mkdir /var/www/html/app

# Set the working directory to the application directory
WORKDIR /var/www/html/app

# Install gemvc/framework using Composer
RUN composer require gemvc/framework

# Copy the existing application code into the container
COPY . .

# Set ownership to www-data
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80
