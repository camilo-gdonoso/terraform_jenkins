provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "foo" {
  ami           = "ami-05fa00d4c63e32376" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  user_data = file("scripts/install_nginx.bat")
  #prueba

  tags = {
    Name = "NginxServer"
  }
}

output "instancia_ip" {
  value = aws_instance.web.public_ip
}
