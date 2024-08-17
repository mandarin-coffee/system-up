#!/bin/bash

cd /var/log
sudo mkdir nginx

sudo docker run -d --name nginx-main -p 80:80 -v /var/log/nginx:/var/log/nginx -v /home/coffee/system-up/nginx-config-files/nginx/conf.d:/etc/nginx/conf.d nginx:alpine

sudo docker ps
