
provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c94855ba95c574c8"
  instance_type = "t2.micro"
  tags = {
    Name = "HelloWorldServer 666"
  }
}

resource "null_resource" "nginx_config" {
  provisioner "remote-exec" {
    inline = [
      "echo 'server { return 200 \"Hello World\"; }' > /tmp/default.conf",
      "sudo yum install -y nginx",
      "sudo mv /tmp/default.conf /etc/nginx/conf.d/default.conf",
      "sudo systemctl restart nginx"
    ]
  }
}