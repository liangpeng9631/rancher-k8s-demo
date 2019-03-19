#/bin/bash

docker stop rancher_mysql

docker rm rancher_mysql

rm -rf /data/rancher_mysql