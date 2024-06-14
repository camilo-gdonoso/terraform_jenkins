provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-05fa00d4c63e32376" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  user_data = file("install_nginx.ps1")
  #prueba

  tags = {
    Name = "NginxServer Nuevo"
  }
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}
