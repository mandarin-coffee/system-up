#!/bin/bash

cd /home/coffee/system-up/apache-config-files/

sudo cp ports.conf /etc/apache2/
sudo cp 000-default.conf /etc/apache2/sites-enabled/

sudo cp log/* /var/log/apache2/
sudo cp -r www/* /var/www/

systemctl restart apache2
