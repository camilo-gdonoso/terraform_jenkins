terraform {
  backend "s3" {
    bucket = "my-eks-cluster-bucket"
    key    = "eks/terraform.state"
    region = "us-east-1"
  }
}