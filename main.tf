# main.tf

provider "aws" {
  region = "us-east-2" # Cambia a la región que prefieras
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0" # AMI de Ubuntu 20.04
  instance_type = "t2.micro" # Cambia al tipo de instancia que desees

  tags = {
    Name = "HelloWorldWebServer"
  }

/*  connection {
    type        = "ssh"
    user        = "ubuntu"
    #private_key = file("~/.ssh/id_rsa") # Cambia a la ruta de tu clave privada SSH
    host        = self.public_ip
  }
*/
  provisioner "remote-exec" {
      connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("C:/Users/camilo/.ssh/id_rsa") # Update with your private key path
      host        = self.public_ip
    }
    inline = [
      "sudo apt update",
      "sudo apt install -y apache2",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2",
      "echo 'Hello, World!' | sudo tee /var/www/html/index.html"
    ]
  }
}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}

