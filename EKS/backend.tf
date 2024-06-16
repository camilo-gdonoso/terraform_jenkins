terraform {
  backend "s3" {
    bucket = "mychileanbucket-eks"
    key    = "eks/terraform.tfstate"
    region = "us-east-2"
  }
}