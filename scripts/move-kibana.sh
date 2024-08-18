#!/bin/bash

cd /home/coffee/system-up/elk-config-files/

cp kibana.yml /etc/kibana/

sudo systemctl restart kibana.service
