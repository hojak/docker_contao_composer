FROM php:8.1-apache

LABEL version="0.1.0" \
	description="Docker Image for a composer installed contao container" \
	maintainer="Holger Janßen-Kroll <docker@ho-jk.de>"

# install all necessary ubuntu packages
RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y \
        git \
        golang \  
        graphviz \
        libssl-dev \
		libbz2-dev \
        libfreetype6-dev \
		libgmp-dev \
		libjpeg-dev \
        libjpeg62-turbo-dev \
		libmcrypt-dev \
		libmcrypt-dev \
        libonig-dev \
        libpng-dev \
        libsodium-dev \
        libssl-dev \
		libxml2-dev \
        libzip-dev \
		mysql-common \
        sudo \
		zlib1g-dev \
	; \
	apt-get clean; \
	rm -rf /var/lib/apt/lists/* \
    ; 

# install the PHP extensions we need
RUN set -ex;\ 
	\
	ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/local/include/; \
	docker-php-ext-configure gd --with-freetype --with-jpeg \
    ; \
    #--with-png-dir=/usr --with-jpeg-dir=/usr; \
	docker-php-ext-install \
        bcmath \
        bz2 \
        gd \
        gmp \
        iconv \
        intl \
        mbstring \
        pdo \
        pdo_mysql\
        soap \
        sodium \
        xmlwriter \
        zip \
    ; \
    CFLAGS="-I/usr/src/php" docker-php-ext-install xmlreader 

# copy composer into image
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

COPY composer.* /var/www/html

RUN cd /var/www/html; \
    sudo -u www-data /usr/local/bin/composer install

# enable apache modules & set document root
RUN a2enmod rewrite expires ;\
    sed -ri -e 's,/var/www/html,/var/www/html/public,g' /etc/apache2/sites-available/*.conf; 

# php settings
RUN set -ex; \
    echo "date.timezone = 'Europe/Berlin'\n" >> /usr/local/etc/php/php.ini;\
    echo "log_errors = on\n" >> /usr/local/etc/php/php.ini;\
    echo "error_reporting = 32767\n" >> /usr/local/etc/php/php.ini;\
    echo "error_log = /var/log/php.error.log\n";\
    ln -sf /dev/stderr /var/log/php.error.log
    # echo "include_path = './:/usr/local/lib/php'\n" >> /usr/local/etc/php/php.ini;
    
# mail hog
RUN go get github.com/mailhog/mhsendmail && \
    cp /root/go/bin/mhsendmail /usr/bin/mhsendmail; \
    echo 'sendmail_path = /usr/bin/mhsendmail --smtp-addr mailhog:1025' >> /usr/local/etc/php/php.ini

VOLUME ["/var/www/html/files", "/var/www/html/templates"]

CMD ["apache2-foreground"]