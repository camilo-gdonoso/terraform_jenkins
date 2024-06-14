
@echo off
yum update -y
amazon-linux-extras install nginx1 -y
systemctl start nginx
systemctl enable nginx
echo Hello, World! > /usr/share/nginx/html/index.html

