terraform {
  backend "s3" {
    bucket = "mychileanbucket"
    key    = "eks/terraform.tfstate"
    region = "us-east-2"
  }
}