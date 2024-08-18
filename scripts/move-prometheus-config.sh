#!/bin/bash

cd /home/coffee/system-up/prometheus-config-files

sudo cp prometheus.yml /etc/prometheus

sudo systemctl restart prometheus
sudo systemctl restart grafana-server
