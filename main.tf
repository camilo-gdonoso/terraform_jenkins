# main.tf

provider "aws" {
  region = "us-east-1" # Cambia a la región que prefieras
}

# Creación de un grupo de seguridad que permita el acceso SSH y HTTP
resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Para mayor seguridad, reemplaza con tu IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creación de un par de claves SSH
resource "aws_key_pair" "ssh_key" {
  key_name   = "my-keypair"   # Nombre descriptivo para el par de claves
  public_key = file("C:/Users/HP/.ssh/my_new_key.pub") # Ruta a tu clave pública
}

# Creación de una instancia EC2
resource "aws_instance" "web_server" {
  ami           = "ami-05fa00d4c63e32376" # AMI de Ubuntu 20.04
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ssh_key.key_name

  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]

  tags = {
    Name = "HelloWorld Nginx"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("C:/Users/HP/.ssh/my_new_key")
      host        = self.public_ip
    }

  inline = [
      "sudo apt update -y",
      "sudo apt install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "echo 'Hello, World!' | sudo tee /var/www/html/index.nginx-debian.html"
    ]
  }
}

# Output de la IP pública de la instancia
output "public_ip" {
  value = aws_instance.web_server.public_ip
}
