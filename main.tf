provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "foo" {
  ami           = "ami-05fa00d4c63e32376" # us-west-2
  instance_type = "t2.micro"
  user_data = file("scripts/install_nginx.sh")

  tags = {
    Name = "NginxServer"
  }
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}
