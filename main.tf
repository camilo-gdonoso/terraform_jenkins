provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  user_data     = file("scripts/install_nginx.sh")

  tags = {
    Name = "NginxServer"
  }
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}
