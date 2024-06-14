# main.tf
terraform{
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region = "ap-south-1" # Cambia a la región que prefieras
  access_key ="variables.access_key"
  secret_key = "variables.secret_key"
}

resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits= 4096
}

variable "key_name" {}

resource "aws_key_pair" "key_pair" {
  key_name = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

resource "local_file" "private_key" {
  content = tls_private_key.rsa_4096.private_key_pem
  filename = var.key_name
}

resource "aws_instance" "public" {
  ami = "ami-0f58b397bc5c1f2e8"
  instance_type = "t2.micro"
  key_name = aws_key_pair.key_pair.key_name
  tags = {
    Name = "public instance"
  }
}

# Output de la IP pública de la instancia
output "public_ip" {
  value = aws_instance.web_server.public_ip
}
