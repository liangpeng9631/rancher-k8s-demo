#/bin/bash

mkdir -p /data/rancher_mysql

tee /data/rancher_mysql/mysqld.cnf <<-'EOF'
[mysqld]
symbolic-links=0
pid-file    = /var/run/mysqld/mysqld.pid
socket      = /var/run/mysqld/mysqld.sock
datadir     = /var/lib/mysql
EOF

#交付rancher使用的mysql
docker run -d \
--name rancher_mysql \
-p 3306:3306 \
-v /data/rancher_mysql/data:/var/lib/mysql \
-v /data/rancher_mysql/log:/var/log/mysql \
-v /data/rancher_mysql/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf \
-v /etc/localtime:/etc/localtime:ro \
-e MYSQL_ROOT_PASSWORD=123456 \
mysql:5.7