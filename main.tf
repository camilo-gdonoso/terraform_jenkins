provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "foo" {
  ami           = "ami-05fa00d4c63e32376" # us-west-2
  instance_type = "t2.micro"
  user_data = file("scripts/install_nginx.bat")

  tags = {
    Name = "NginxServer"
  }
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}
