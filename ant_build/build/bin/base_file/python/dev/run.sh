#!/bin/sh

/data/python372/bin/uwsgi --ini /data/server/#projectName#/uwsgi.ini &

/data/nginx/sbin/nginx -g 'daemon off;' -c /data/nginx/conf/nginx.conf