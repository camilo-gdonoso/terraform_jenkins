#!/bin/bash

# Actualizar el sistema
sudo yum update -y

# Instalar Nginx
sudo yum install -y nginx

# Iniciar y habilitar el servicio Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Crear la página de bienvenida
echo 'Hello, World!' | sudo tee /var/www/html/index.html
