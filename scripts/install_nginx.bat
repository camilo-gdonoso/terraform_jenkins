@echo off
@echo off

:: Add Chocolatey path to PATH environment variable
set PATH=%PATH%;C:\ProgramData\chocolatey\bin

:: Rest of your .bat file commands
choco install nginx -y
:: Instalar NGINX
echo Instalando NGINX...
choco install nginx -y

:: Configurar NGINX
echo Configurando NGINX...
echo "server {
    listen 95;
    server_name localhost_nginx;
    location / {
        root C:/nginx/html;
        index index.html;
    }
}" > C:/nginx/conf/nginx.conf

:: Crear un archivo index.html
echo "<html><body><h1>Hello, World!</h1></body></html>" > C:/nginx/html/index.html

:: Iniciar NGINX
echo Iniciando NGINX...
nginx
:: Reiniciar NGINX
echo Reiniciando NGINX...
nginx -s reload

echo NGINX instalado y configurado exitosamente.