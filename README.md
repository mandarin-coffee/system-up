# Настройка и конфигурирование веб сервера

### Важно перед началом настройки необходимо отредактировать конфиги:

- __elk-config-files/filebeat.yml__: поменять ip адрес в строке __161: hosts: ["ip_addr:5400"]__
- __nginx-config-files/nginx/conf.d/default.conf__: поменять ip адреса в блоке __upstream__
- __prometheus-config-files/prometheus.yml__: поменять/добавить ip адреса в строке __44: targets: ['ip_addr_1:9100', 'ip_addr_2:9100']__

Установка и настройка машины web-server:
- В начале установим и настроим apache. Для этого выполним следующие команды
- - ```bash
    sudo apt install -y apache2
    ```
  - ```bash
    bash move-apache-configs.sh
    ```
  - Затем можно проверить работоспособность apache
