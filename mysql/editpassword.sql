use mysql;

select host, user from user;

grant all privileges on *.* to root@'%' identified by '123456' with grant option;

flush privileges;