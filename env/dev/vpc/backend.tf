terraform {
  backend "s3" {
    bucket = "dev-tfstate-aws-iac-study"
    key = "vpc/teffaform.tfstate"
    region = "us-east-1"
  }
}
