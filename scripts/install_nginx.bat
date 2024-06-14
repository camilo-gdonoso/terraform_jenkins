@echo off
:: Actualizar el sistema
yum update -y

:: Instalar NGINX
amazon-linux-extras install nginx1 -y

:: Iniciar NGINX
net start nginx

:: Habilitar el inicio automático de NGINX
sc config nginx start= auto

:: Crear un archivo index.html
echo Hello, World! > C:\Program Files\nginx\html\index.html

:: Añadir un comando para registrar la ejecución del script
echo Script install_nginx.bat ejecutado correctamente > C:\tmp\install_nginx_log.txt
