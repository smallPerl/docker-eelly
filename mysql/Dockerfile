# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
FROM mysql:5.7

ENV MYSQL_ALLOW_EMPTY_PASSWORD yes

RUN sed -i -e "s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

#将所需文件放到容器中
COPY setup.sh /mysql/setup.sh
COPY oauth.sql /mysql/oauth.sql
COPY editpassword.sql /mysql/editpassword.sql

#设置容器启动时执行的命令
CMD ["sh", "/mysql/setup.sh"]


