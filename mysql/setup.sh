#!/bin/bash
set -e

echo '0.检查  mysql....'

echo `service mysql status`
service mysql stop

echo `service mysql status`

echo '..................检查 mysql  结束....'

echo '1.开始启动mysql....'

#启动mysql
service mysql start

sleep 3

echo `service mysql status`
echo '2.开始导入数据....'

#导入数据
mysql < /mysql/oauth.sql

echo '3.导入数据完毕....'

sleep 3
echo `service mysql status`

#重新设置mysql密码
echo '4.开始修改密码....'

mysql < /mysql/editpassword.sql

echo '5.修改密码完毕....'

#sleep 3
echo `service mysql status`

echo "mysql容器启动完毕,且数据导入成功"

tail -f /dev/null