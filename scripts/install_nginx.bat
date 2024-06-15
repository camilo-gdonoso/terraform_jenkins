@echo off

set "nginx_dir=C:\nginx"

:: Install NGINX
choco install nginx -y

:: Configure NGINX
echo Installing and configuring NGINX...
(
echo server {
echo     server_name localhost_nginx;
echo     listen 8800;
echo     root %nginx_dir%\html;
echo     index index.html;
echo }
) > %nginx_dir%\conf\nginx.conf

:: Create index.html
echo "<html><body><h1>Hello, World!</h1></body></html>" > %nginx_dir%\html\index.html

:: Start NGINX
nginx -s reload

