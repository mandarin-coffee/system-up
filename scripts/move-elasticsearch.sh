#!/bin/bash

cd /home/coffee/system-up/elk-config-files/

cp jvm.options /etc/elasticsearch/jvm.options.d/
cp elasticsearch.yml /etc/elasticsearch/

sudo systemctl restart elasticsearch.service
