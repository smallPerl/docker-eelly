FROM alpine:3.4

MAINTAINER Vincent Composieux <vincent.composieux@gmail.com>

RUN apk add --update nginx
RUN rm -rf /var/cache/apk/* && rm -rf /tmp/*

ADD nginx.conf /etc/nginx/
ADD sites-available/*.conf /etc/nginx/sites-enabled/

RUN echo "upstream php5-upstream { server php5:9000; }" > /etc/nginx/conf.d/php5upstream.conf
RUN echo "upstream php7-upstream { server php7:9000; }" > /etc/nginx/conf.d/php7upstream.conf
RUN adduser -D -g '' -G www-data www-data

RUN chmod 777 /var/lib/nginx -R

COPY api.crt /etc/nginx/
COPY api.key /etc/nginx/

CMD ["nginx"]

EXPOSE 80
EXPOSE 443