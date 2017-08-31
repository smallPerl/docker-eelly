FROM php:7.1.7-fpm-alpine

WORKDIR /data/www

ENV PHALCON_VERSION=3.2.2

# compile phalcon
RUN set -xe && \
    apk add --no-cache --virtual .build-deps autoconf g++ make pcre-dev re2c && \
        curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz && \
        tar xzf v${PHALCON_VERSION}.tar.gz && cd cphalcon-${PHALCON_VERSION}/build && sh install && \
        docker-php-ext-enable phalcon

# add pdo_mysql extension
RUN docker-php-ext-install pdo_mysql mysqli 

# add mongodb extension
RUN set -xe && \
    apk add --no-cache --virtual openssl-dev && \
    #libmemcached &&\
    pecl install mongodb-1.2.9 && \
    docker-php-ext-enable mongodb
        
#add redis
RUN docker-php-source extract && \
  apk add --update --no-cache autoconf g++ make && \
  pecl install redis && \
  docker-php-ext-enable redis && \
  docker-php-source delete 

#add memcached
RUN apk --update add wget \
  libmemcached-dev \
  libmcrypt-dev \
  cyrus-sasl-dev\
  automake

RUN pecl install memcached && docker-php-ext-enable memcached

#RUN pecl channel-update pecl.php.net && pecl install xdebug-2.5.5 && docker-php-ext-enable xdebug

RUN apk upgrade --update && apk add \
  git \
    && git clone https://github.com/tideways/php-profiler-extension.git /usr/src/php/ext/tideways \
    && cd /usr/src/php/ext/tideways\
    && docker-php-ext-install tideways \
    && rm -rf /var/cache/apk/* 

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

RUN apk upgrade --update && apk add \
  git \
    && git clone https://github.com/swoole/swoole-src.git /usr/src/php/ext/swoole \
    && cd /usr/src/php/ext/swoole\
    && sed -i -e "s/\#define HAVE_LINUX_AIO/ /" ./swoole_config.h \
    && docker-php-ext-install swoole\
    && rm -rf /var/cache/apk/* 


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

ADD php.ini /usr/local/etc/php/
RUN chmod 777 /data/www/ -R
RUN docker-php-ext-install bcmath 
RUN pecl install igbinary && docker-php-ext-enable igbinary