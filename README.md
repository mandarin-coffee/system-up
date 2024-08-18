# Настройка и конфигурирование веб сервера

### Важно перед началом настройки необходимо отредактировать конфиги:

- __elk-config-files/filebeat.yml__: поменять ip адрес в строке __161: hosts: ["ip_addr:5400"]__
- __nginx-config-files/nginx/conf.d/default.conf__: поменять ip адреса в блоке __upstream__
- __prometheus-config-files/prometheus.yml__: поменять/добавить ip адреса в строке __44: targets: ['ip_addr_1:9100', 'ip_addr_2:9100']__
- __scripts/move-mysql-config-slave.sh__: обновить __SOURCE_HOST='ip_addr'__

#### Установка и настройка машины web-server:
- В начале установим и настроим apache. Для этого выполним следующие команды:
  ```bash
  sudo apt install -y apache2
   ```
  ```bash
   bash move-apache-configs.sh
  ```
- Затем можно проверить работоспособность apache
  - Переходим по адресам которые получили в ip -4 a и в конце добавляем __ip:8081 ip:8082 ip:8083__
- Для установки балансировщика __nginx__ будем использовать __docker__
  - Установим докер и скачаем образ nginx:alpine :
    ```bash
    sudo apt install -y docker.io
    ```
    ```bash
    sudo docker pull nginx:alpine
    ```
  - Далее выполняем скрипт (Он создаст директорию для логов и прокинет конфигурационный файл, который мы редактировали выше)
    ```bash
    bash create-logs-dir-and-start-docker.sh
    ```
  - Теперь можно перейти по адресу машины не указывая порта например __192.168.0.104 (У вас будет свой адерс машины узнать его:)__
    ```bash
    ip -4 a
    ```
- После проверки работоспособности настроим __mysql source__
  - Для этого установим mysql
    ```bash
    sudo apt install -y mysql-server-8.0
    ```
  - После того как mysql установился выполняем скрипт
    ```bash
    bash move-mysql-config-master.sh
    ```
- Сразу же заранее предустановим еще 2 компонета для мониторинга системы и сборщика логов
  ```bash
  sudo apt install prometheus-node-exporter
  ```
  ```bash
  sudo dpkg -i filebeat_8.9.1_amd64-224190-e0af99.deb
  ```
  *__Filebeat__ можно скачать через vpn, в моем случае я его залил заранее.*
- Перенести конфиг filebeat
  ```bash
  bash move-filebeat.sh
  ```
___
#### Установка и настройка машины slave prometheus grafana:
На этой машине будет репликация базы данных с основного сервера и монтироинг
- Установим mysql
  ```bash
  sudo apt install -y mysql-server-8.0
  ```
- Настроим репликацию
  ```bash
  bash move-mysql-config-slave.sh
  ```
- Установим prometheus
  ```bash
  sudo apt install -y prometheus prometheus-node-exporter
  ```
- Установим grafana
  ```bash
  sudo apt install -y adduser libfontconfig1 musl
  ```
  ```bash
  sudo dpkg -i grafana-enterprise_11.1.3_amd64.deb
  ```
- Перенесем конфиги prometheus и перезапустим сервисы prometheus и grafana
  ```bash
  bash move-prometheus-config
  ```
- Далее происходит настройка __grafana__ по адресу __ip_addr:3000__
___
#### Установка и настройка машины elk:
Эта машина будет собирать логи nginx с возможностью их мониторинга
- Сначала необходимо провалиться в супер пользователя __sudo su__
- Уставновить __java__ для elasticsearch
  ```bash
  apt install -y default-jdk
  ```
- Выполним установку необходимых пакетов через __dpkg__ загруженных заранее
  ```bash
  dpkg -i elasticsearch_8.9.1_amd64-224190-300799.deb
  ```
- После установки выполнить перезагрузку демона и активацию elasticsearch
  ```bash
  systemctl daemon-reload
  ```
  ```bash
  systemctl enable --now elasticsearch.service
  ```
- Перенесем конфиги elasticsearch
  ```bash
  bash move-elasticsearch.sh
  ```
- Далее установка kibana также через dpkg
  ```bash
  dpkg -i kibana_8.9.1_amd64-224190-68eb0f.deb
  ```
- Затем также перезагрузка демона и активация kibana
  ```bash
  systemctl daemon-reload
  ```
  ```bash
  systemctl enable --now kibana.service
  ```
- Перенесем конфиги kibana
  ```bash
  bash move-kibana.sh
  ```
- После устанвока logstash
 ```bash
  dpkg -i logstash_8.9.1_amd64-224190-e8ea1a.deb
  ```
- Перенесем конфиги logstash
  ```bash
  bash move-logstash.sh
  ```
