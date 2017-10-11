#新生成的镜像是基于centos7.3:nginx v1.12.1镜像
FROM centos:centos7

MAINTAINER by xiaobing <wuxiaobing@eelly.net>

ENV PATH /usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$PATH
ENV TZ "Asia/Shanghai"
RUN mkdir -p /data/software/nginx /data/logs /usr/local/webserver /data/web

RUN yum install wget yum gcc gcc-c++ patch openssl openssl-devel ncurses-devel libxml2-devel libjpeg-devel libpng-devel autoconf libtool-libs glibc-devel glibc-static glib2-devel fontconfig fontconfig-devel libxslt libxslt-devel e2fsprogs e2fsprogs-devel epel-release zlib zlib-devel bzip2 bzip2-devel automake unzip libjpeg libpng libvpx libvpx-devel libXpm libXpm-devel libxml2 libX11-devel libX11 ncurses libwebp-devel libwebp -y
RUN yum remove python-firewall firewalld firewalld-filesystem iptables iptables-devel -y \
 && yum clean all
RUN wget -P /data/software/nginx http://172.18.107.97:8090/php/qrencode-3.4.4.tar.gz \
 && wget -P /data/software/nginx http://172.18.107.97:8090/nginx/nginx-1.12.1.tar.gz \
 && wget -P /data/software/nginx http://172.18.107.97:8090/php/pcre-8.40.tar.gz \
 && wget -P /data/software/nginx http://172.18.107.97:8090/php/libgd-2.2.5.tar.gz \
 && wget -P /data/software/nginx http://172.18.107.97:8090/nginx/echo-nginx-module-master.tar.gz \
 && wget -P /data/software/nginx http://172.18.107.97:8090/nginx/headers-more-nginx-module-master.tar.gz \
 && wget -P /data/software/nginx http://172.18.107.97:8090/nginx/memc-nginx-module-master.tar.gz \
 && wget -P /data/software/nginx http://172.18.107.97:8090/nginx/nginx-rewrite-request-body-module-master.tar.gz \
 && wget -P /data/software/nginx http://172.18.107.97:8090/nginx/ngx-http-status-code-counter-master.tar.gz \
 && wget -P /data/software/nginx http://172.18.107.97:8090/nginx/ngx_devel_kit-master.tar.gz \
 && wget -P /data/software/nginx http://172.18.107.97:8090/nginx/ngx_http_var_request_speed-master.tar.gz \
 && wget -P /data/software/nginx http://172.18.107.97:8090/nginx/ngx_realtime_request_module-master.tar.gz \
 && wget -P /data/software/nginx http://172.18.107.97:8090/nginx/set-misc-nginx-module-master.tar.gz \
 && wget -P /data/software/nginx http://172.18.107.97:8090/nginx/srcache-nginx-module-master.tar.gz \
 && wget -P /data/software/nginx http://172.18.107.97:8090/nginx/ngx_http_qrcode_module-master.tar.gz

RUN groupadd www && useradd -g www www -s /sbin/nologin
RUN echo '/usr/local/lib' >> /etc/ld.so.conf.d/local.conf

WORKDIR /data/software/nginx
RUN tar zxvf echo-nginx-module-master.tar.gz \
 && tar zxvf headers-more-nginx-module-master.tar.gz \
 && tar zxvf memc-nginx-module-master.tar.gz \
 && tar zxvf nginx-rewrite-request-body-module-master.tar.gz \
 && tar zxvf ngx-http-status-code-counter-master.tar.gz \
 && tar zxvf ngx_devel_kit-master.tar.gz \
 && tar zxvf ngx_http_var_request_speed-master.tar.gz \
 && tar zxvf ngx_realtime_request_module-master.tar.gz \
 && tar zxvf set-misc-nginx-module-master.tar.gz \
 && tar zxvf srcache-nginx-module-master.tar.gz \
 && tar zxvf ngx_http_qrcode_module-master.tar.gz

RUN tar zxvf libgd-2.2.5.tar.gz \
 && tar zxvf pcre-8.40.tar.gz \
 && tar zxvf qrencode-3.4.4.tar.gz \
 && tar zxvf nginx-1.12.1.tar.gz
WORKDIR /data/software/nginx/libgd-2.2.5
RUN ./configure --with-zlib --with-fontconfig --with-png --with-freetype --with-jpeg --with-xpm --with-vpx && make && make install

WORKDIR /data/software/nginx/pcre-8.40
RUN ./configure --prefix=/usr/local/webserver/pcre/ \
--enable-jit --enable-utf \
--enable-unicode-properties \
--enable-pcregrep-libz \
--enable-pcregrep-libbz2 \
--enable-pcre16 --enable-pcre32 \
--enable-newline-is-anycrlf \
--enable-bsr-anycrlf \
 && make && make install && ldconfig

WORKDIR /data/software/nginx/qrencode-3.4.4
RUN ./configure  --enable-thread-safety --with-tools && make && make install && ldconfig
WORKDIR /data/software/nginx/nginx-1.12.1

RUN CFLAGS="$CFLAGS -O3" CXXFLAGS="$CXXFLAGS -O3" ./configure --user=www --group=www --prefix=/usr/local/webserver/nginx12 \
--with-poll_module --with-threads --with-file-aio --with-http_ssl_module --with-http_v2_module \
--with-http_realip_module --with-http_addition_module --with-http_xslt_module --with-http_image_filter_module \
--with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module \
--with-http_gunzip_module --with-http_gzip_static_module --with-http_auth_request_module --with-http_random_index_module \
--with-http_secure_link_module --with-http_degradation_module --with-http_slice_module --with-http_stub_status_module \
--without-http_memcached_module \
--with-stream --with-stream_ssl_module --with-stream_realip_module --with-stream_ssl_preread_module \
--with-pcre=/data/software/nginx/pcre-8.40 --with-pcre-jit \
--add-module=../echo-nginx-module-master --add-module=../headers-more-nginx-module-master --add-module=../memc-nginx-module-master \
--add-module=../nginx-rewrite-request-body-module-master --add-module=../ngx_devel_kit-master \
--add-module=../ngx-http-status-code-counter-master --add-module=../ngx_http_var_request_speed-master --add-module=../ngx_realtime_request_module-master \
--add-module=../set-misc-nginx-module-master --add-module=../srcache-nginx-module-master --add-module=../ngx_http_qrcode_module-master 

RUN make && make install 
RUN mkdir -p /usr/local/webserver/nginx12/conf/vhost
COPY conf/nginx.conf conf/server.ssl.conf /usr/local/webserver/nginx12/conf/
COPY conf/eelly.* /usr/local/webserver/nginx12/
COPY conf/vhost/*.conf  /usr/local/webserver/nginx12/conf/vhost/
ADD  conf/rewrite/*.conf /usr/local/webserver/nginx12/conf/rewrite/

COPY conf/api.crt /usr/local/webserver/nginx12/
COPY conf/api.key /usr/local/webserver/nginx12/
COPY conf/ssl.crt /usr/local/webserver/nginx12/
COPY conf/ssl.key /usr/local/webserver/nginx12/
COPY conf/eelly.dev.crt /usr/local/webserver/nginx12/
COPY conf/eelly.dev.key /usr/local/webserver/nginx12/
COPY conf/server.fastcgi.conf /usr/local/webserver/nginx12/
COPY conf/server.safe.conf /usr/local/webserver/nginx12/
COPY conf/site.pagecache.conf /usr/local/webserver/nginx12/

ADD  conf/addFile/* /usr/local/webserver/nginx12/

WORKDIR /data/software
RUN rm -fr nginx && chmod -R 777 /data/logs /data/web

WORKDIR /
EXPOSE 80
EXPOSE 443

ENTRYPOINT /usr/local/webserver/nginx12/sbin/nginx -c /usr/local/webserver/nginx12/conf/nginx.conf -g "daemon off;"
