terraform {
  backend "s3" {
    bucket = "dev-tfstate-aws-iac-study"
    key = "dev/sqs_study/teffaform.tfstate"
    region = "us-east-1"
  }
}
