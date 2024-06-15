# main.tf

provider "aws" {
  region = "ap-south-1" # Cambia a la región que prefieras
}

# Creación de un grupo de seguridad que permita el acceso SSH y HTTP
resource "aws_security_group" "hello-terra-ssh-http" {
  name        = "hello-terra-ssh"
  description = "Allow SSH and HTTP inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

# Creación de un par de claves SSH
/*resource "aws_key_pair" "ssh_key" {
  key_name   = "my-keypair"   # Nombre descriptivo para el par de claves
  public_key = file("C:/Users/HP/.ssh/mi_nueva_key.pub") # Ruta a tu clave públicaa
}
*/
# Creación de una instancia EC2
resource "aws_instance" "hello_terra" {
  ami           = "ami-08a0d1e16fc3f61ea" # Amazon Linux AMI
  instance_type = "t2.micro"
  availability_zone = "ap-south-1a"

  //key_name      = aws_key_pair.ssh_key.key_name
  security_groups = ["${aws_security_group.hello_terra-ssh-http.name}"]
  key_name="nn-terraform"
  user_data = <<-EOF
  #! /bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
  echo "<h1>Hello World from $(hostname -f)</h1>" >> /var/www/html/index.html
  EOF
  tags = {
    Name = "HelloWorld Nginx Luck"
  }
 // provisioner "file" {
  //  source      = "setup_nginx.sh"
  //  destination = "/tmp/setup_nginx.sh"
  //}

 // provisioner "remote-exec" {
    /*
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("C:/Users/HP/.ssh/mi_nueva_key.pem")
      host        = self.public_ip
    }
*/
 // script = "/tmp/setup_nginx.sh"

  //}
  
}

# Output de la IP pública de la instancia
output "public_ip" {
  value = aws_instance.web_server.public_ip
}
