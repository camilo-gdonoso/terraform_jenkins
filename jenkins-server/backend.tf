terraform {
  backend "s3" {
    bucket = "mychileanbucket"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-2"
  }
}