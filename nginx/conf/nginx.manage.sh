#!/bin/bash
#20170707 NGINX

BINDIR=/usr/local/webserver/nginx12
LOGDIR=/data/logs
LOGLINE=5000

# Nginx
function ngx_start() {
  ${BINDIR}/sbin/nginx -c ${BINDIR}/conf/nginx.conf
}

# 停止 Nginx
function ngx_stop() {
  ${BINDIR}/sbin/nginx -c ${BINDIR}/conf/nginx.conf -s stop
}

# 重新加载配置文件
function ngx_reload() {
  ${BINDIR}/sbin/nginx -c ${BINDIR}/conf/nginx.conf -s reload
}

# 检查配置文件语法
function ngx_test() {
  ${BINDIR}/sbin/nginx -c ${BINDIR}/conf/nginx.conf -t
}

case "$1" in
  start)
   ngx_start
  ;;
  stop)
   ngx_stop
  ;;
  restart)
   ngx_stop
   sleep 1
   ngx_start
  ;;
  reload)
   ngx_reload
  ;;
  test)
   ngx_test
  ;;
  *)
   echo "使用说明: $0 {start|stop|reload|test|stat|block|merge|rotate}"
   echo "参数说明："
   echo "start   启动 Nginx 服务"
   echo "stop    关闭 Nginx 服务"
   echo "restart 重启 Nginx 服务"
   echo "reload  重新加载 Nginx 配置文件"
   echo "test    检查配置文件语法是否正确"
   exit 3
 ;;
esac
