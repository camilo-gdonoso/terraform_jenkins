@echo off

:: Add Chocolatey path to PATH environment variable
set "PATH=%PATH%;C:\ProgramData\chocolatey\bin"

:: Install NGINX
choco install nginx -y

:: Configure NGINX
echo Installing and configuring NGINX...
(
echo server {
echo     listen 9090;
echo     server_name localhost_nginx;
echo     location / {
echo         root C:/nginx/html;
echo         index index.html;
echo     }
echo }
) > C:/nginx/conf/nginx.conf

:: Create index.html
echo "<html><body><h1>Hello, World!</h1></body></html>" > C:/nginx/html/index.html

:: Start NGINX
nginx -s reload

echo NGINX installed and configured successfully.
