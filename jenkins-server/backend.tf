terraform {
  backend "s3" {
    bucket = "cicd-terraform-eks"
    key    = "jenkins/terraform.state"
    region = "us-east-1"
  }
}