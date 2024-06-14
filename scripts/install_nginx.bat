@echo off
:: Actualizar el sistema
echo Actualizando el sistema...
yum update -y

:: Instalar NGINX
echo Instalando NGINX...
amazon-linux-extras install nginx1 -y

:: Iniciar NGINX
echo Iniciando NGINX...
systemctl start nginx

:: Habilitar el inicio automático de NGINX
echo Habilitando el inicio automático de NGINX...
systemctl enable nginx

:: Crear un archivo index.html
echo "Hello, World!" > /usr/share/nginx/html/index.html

echo NGINX instalado y configurado exitosamente.
