# Install NGINX
choco install nginx -y

# Start NGINX service
Start-Service nginx

# Stop NGINX service temporarily to modify the configuration
Stop-Service nginx

# Copy the custom index.html file to the NGINX web root directory
Copy-Item -Path .\index.html -Destination C:\nginx\html

# Restart NGINX service
Start-Service nginx