#!/bin/bash
yum update -y
amazon-linux-extras install nginx1 -y
systemctl start nginx
systemctl enable nginx
echo "Hello, World!" > /usr/share/nginx/html/index.html

# Añadir un comando para registrar la ejecución del script
echo "Script install_nginx.sh ejecutado correctamente" > /tmp/install_nginx_log.txt

