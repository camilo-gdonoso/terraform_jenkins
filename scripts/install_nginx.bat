@echo off

:: Instalar Chocolatey (si no está instalado)
echo Verificando la instalación de Chocolatey...
if not exist "C:\ProgramData\chocolatey" (
    echo Instalando Chocolatey...
    @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
)

:: Instalar NGINX
echo Instalando NGINX...
choco install nginx -y

:: Configurar NGINX
echo Configurando NGINX...
echo "server {
    listen 80;
    server_name localhost;
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

echo NGINX instalado y configurado exitosamente.