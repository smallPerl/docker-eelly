FROM php:7.1.7-fpm-alpine

WORKDIR /data/web

ENV PHALCON_VERSION=3.2.2


RUN chmod 777 /data/web/ -R

#安装调用组件
RUN apk add --no-cache --virtual .build-deps wget \
  libmcrypt-dev \
  cyrus-sasl-dev\
  automake \
  git \
  openssl-dev \
  autoconf \
  g++ make cmake \
  pcre-dev \
  re2c \
  libmemcached-dev zlib-dev libgsasl-dev cyrus-sasl-dev \
  libxml2-dev \
  freetype-dev \
  libjpeg-turbo-dev \
  libpng-dev \
  libmcrypt-dev \
  libxml2 

#直接 pecl 安装
# add pdo_mysql extension
RUN docker-php-ext-install pdo_mysql mysqli 
RUN pecl install igbinary && docker-php-ext-enable igbinary
  
# compile phalcon
RUN set -xe && \
    curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz && \
    tar xzf v${PHALCON_VERSION}.tar.gz && cd cphalcon-${PHALCON_VERSION}/build && sh install && \
    docker-php-ext-enable phalcon

# add mongodb extension
RUN set -xe && \
    pecl install mongodb-1.2.9 && \
    docker-php-ext-enable mongodb
        
ENV REDIS_VERSION=3.1.3
RUN cd /tmp \
    && pecl download redis-${REDIS_VERSION} \
    && tar zxvf redis-${REDIS_VERSION}.tgz \
    && cd redis-${REDIS_VERSION} \
    && phpize \
    && ./configure --enable-redis-igbinary \
    && make \
    && make install \
    && docker-php-ext-enable redis \
    && rm -rf /tmp/reids-${REDIS_VERSION}*

#RUN pecl install memcached && docker-php-ext-enable memcached
RUN docker-php-source extract
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS  && \
    git clone --branch v3.0.3 https://github.com/php-memcached-dev/php-memcached.git /usr/src/php/ext/memcached/ \
    && docker-php-ext-configure memcached --enable-memcached-igbinary  \
    && docker-php-ext-install memcached

#RUN pecl channel-update pecl.php.net && pecl install xdebug-2.5.5 && docker-php-ext-enable xdebug

RUN git clone https://github.com/tideways/php-profiler-extension.git /usr/src/php/ext/tideways \
    && cd /usr/src/php/ext/tideways\
    && docker-php-ext-install tideways 

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

RUN git clone https://github.com/swoole/swoole-src.git /usr/src/php/ext/swoole \
    && cd /usr/src/php/ext/swoole\
    && sed -i -e "s/\#define HAVE_LINUX_AIO/ /" ./swoole_config.h \
    && docker-php-ext-install swoole

ENV RABBITMQ_VERSION v0.8.0
ENV PHP_AMQP_VERSION v1.9.0
RUN git clone --branch ${RABBITMQ_VERSION} https://github.com/alanxz/rabbitmq-c.git /tmp/rabbitmq \
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
    && docker-php-ext-enable amqp   

RUN set -ex \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/freetype2/freetype \
        --with-jpeg-dir=/usr/include \
        --with-png-dir=/usr/include \
    && docker-php-ext-install soap gd bcmath zip opcache iconv mcrypt pdo pcntl sockets shmop xmlrpc \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*

RUN set -xe &&  wget -q -O - http://www.xunsearch.com/scws/down/scws-1.2.1.tar.bz2 | tar xjf - &&\
    cd scws-1.2.1 && \
    sed -i '29i #endif '  ./libscws/xdb.c && \
    sed -i '29i #include <sys/file.h> '  ./libscws/xdb.c && \
    sed -i '29i #ifdef HAVE_FLOCK'  ./libscws/xdb.c && \
     ./configure && make install && \
    git clone https://github.com/hightman/scws.git /usr/local/php/ext/scws && \
    cd /usr/local/php/ext/scws/phpext \
    && phpize \
    && ./configure \
    && make  \
    && make install \
    && make test \
    && docker-php-ext-enable scws 

RUN rm -rf /tmp/* && rm -rf /var/cache/apk/*

ADD php.ini /usr/local/etc/php/

#需要安装性能测试站点才打开
#RUN set -xe && git clone https://github.com/perftools/xhgui.git /data/xhgui.eelly.dev 
#COPY xhgui_config.php /data/xhgui.eelly.dev/config/config.php
#COPY xhgui_composer.json /data/xhgui.eelly.dev/
#RUN set -xe && cd /data/xhgui.eelly.dev && php install.php

