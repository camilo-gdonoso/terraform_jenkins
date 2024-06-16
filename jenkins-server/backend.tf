terraform {
  backend "s3" {
    bucket = "cicd-camilo-terraform-jenkins"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}