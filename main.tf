
provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "allow_ssh_ping" {
  name        = "allow-ssh-ping"
  description = "Permite trafico SSH y ICMP (ping)"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Permite el trafico SSH desde cualquier lugar
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]  # Permite el trafico ICMP desde cualquier lugar
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nginx_server" {
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  key_name      = "key_pair"
  security_groups = [aws_security_group.allow_ssh_ping.name]

provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install nginx1.12 -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
    ]
  }
  tags = {
    Name = "nginx_server oficial"
  }
}
resource "null_resource" "create_hello_world" {
  depends_on = [aws_instance.nginx_server]

  provisioner "remote-exec" {
      connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("/home/vboxuser/Downloads/key_pair.pem")
      host        = aws_instance.nginx_server.public_ip
    }
    inline = [
      "echo '<html><body><h1>Hello world</h1></body></html>' | sudo tee /usr/share/nginx/html/index.html",
      "sudo systemctl restart nginx",
    ]
  }
}

output "instance_ip" {
  value = aws_instance.nginx_server.public_ip
}

  #vpc_security_group_ids = [aws_security_group.web_server_security_group.id]

/*
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
    from_port   = 20
    to_port     = 20
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
      "echo 'server { listen 90; location / { return 200 \"Hello World\"; }}' > /etc/nginx/conf.d/default.conf",
      "sudo yum install -y nginx",
      "sudo systemctl restart nginx"
    ]
  }
  }
*/