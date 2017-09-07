FROM php:5.6.31-fpm-alpine

WORKDIR /data/www

ENV PHALCON_VERSION=3.2.1

# compile phalcon extension
RUN set -xe && \
    apk add --no-cache --virtual .build-deps autoconf g++ make pcre-dev re2c && \
        curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz && \
        tar xzf v${PHALCON_VERSION}.tar.gz && cd cphalcon-${PHALCON_VERSION}/build && sh install && \
        docker-php-ext-enable phalcon

RUN pecl install igbinary && docker-php-ext-enable igbinary

# add memcached extension
RUN apk update && apk add libmemcached-dev zlib-dev libgsasl-dev cyrus-sasl-dev \
    && cd /tmp \
    && pecl download memcached-2.2.0 \
    && tar zxpf memcached-2.2.0.tgz \
    && cd memcached-2.2.0 \
    && phpize \
    && ./configure --enable-memcached-igbinary --enable-memcached-json \
    && make \
    && make install \
    && docker-php-ext-enable memcached \
    && rm -rf /tmp/memcached-2.2.0*

# add redis extension
RUN set -xe && \
    pecl install redis-3.1.3 &&\
    docker-php-ext-enable redis

# add mongodb extension
RUN set -xe && \
    apk add --no-cache --virtual openssl-dev && \
    pecl install mongodb-1.2.9 && \
    docker-php-ext-enable mongodb

ADD php.ini /usr/local/etc/php/
RUN chmod 777 /data/www/ -R

ENV RABBITMQ_VERSION v0.8.0
ENV PHP_AMQP_VERSION v1.9.0
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS git cmake openssl-dev \
	&& git clone --branch ${RABBITMQ_VERSION} https://github.com/alanxz/rabbitmq-c.git /tmp/rabbitmq \
		&& cd /tmp/rabbitmq \
		&& mkdir build && cd build \
		&& cmake .. \
		&& cmake --build . --target install \
		# workaround for linking issue
		&& cp -r /usr/local/lib64/* /usr/lib/ \
	&& git clone --branch ${PHP_AMQP_VERSION} https://github.com/pdezwart/php-amqp.git /tmp/php-amqp \
		&& cd /tmp/php-amqp \
		&& phpize \
		&& ./configure \
		&& make  \
		&& make install \
		&& make test \
	&& docker-php-ext-enable amqp \
	&& apk del .build-deps && rm -rf /tmp/*

RUN apk upgrade --update && apk add \
  git \
    && git clone https://github.com/tideways/php-profiler-extension.git /usr/src/php/ext/tideways \
    && cd /usr/src/php/ext/tideways\
    && docker-php-ext-install tideways \
    && rm -rf /var/cache/apk/*

 #GD extension pdo_mysql extension
RUN apk add --no-cache --virtual .build-deps \
        libxml2-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libmcrypt-dev \
        libxml2

RUN set -ex \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/freetype2/freetype \
        --with-jpeg-dir=/usr/include \
        --with-png-dir=/usr/include \
    && docker-php-ext-install soap gd bcmath zip opcache pdo_mysql mysqli iconv mcrypt pdo pcntl sockets shmop xmlrpc \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*


