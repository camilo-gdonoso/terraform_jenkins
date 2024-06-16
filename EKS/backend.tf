terraform {
  backend "s3" {
    bucket = "cicd-camilo-terraform-eks"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}