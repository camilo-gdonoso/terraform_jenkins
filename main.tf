
provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c94855ba95c574c8"
  instance_type = "t2.micro"
  tags = {
    Name = "HelloWorldServer 666"
  }
  vpc_security_group_ids = [aws_security_group.web_server_security_group.id]
}

resource "aws_security_group" "web_server_security_group" {
  name        = "web_server_security_group"
  description = "Security group for web server"

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "web" {
  ami           = "ami-0c94855ba95c574c8"
  instance_type = "t2.micro"
  tags = {
    Name = "WebServer"
  }
  vpc_security_group_ids = [aws_security_group.web_security_group.id]
}

resource "aws_security_group" "web_security_group" {
  name        = "web_security_group"
  description = "Security group for web server"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "null_resource" "nginx_config" {
  provisioner "remote-exec" {
    inline = [
      "echo 'server { listen 80; location / { return 200 \"Hello World\"; }}' > /etc/nginx/conf.d/default.conf",
      "sudo yum install -y nginx",
      "sudo systemctl restart nginx"
    ]
  }
  }
