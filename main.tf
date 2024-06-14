provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "foo" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  user_data = file("scripts/install_nginx.bat")

  tags = {
    Name = "NginxServer"
  }
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}
