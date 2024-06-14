@echo off

:: Install NGINX using Chocolatey
choco install nginx -y

:: Configure NGINX
echo "server {
    listen 90;
    server_name localhost;
    location / {
        root C:\nginx\html;
        index index.html;
    }
}" > C:\nginx\conf\nginx.conf

:: Create an index.html file
echo "<html><body><h1>Hello, World!</h1></body></html>" > C:\nginx\html\index.html

:: Start NGINX
nginx

echo NGINX installed and configured successfully.
