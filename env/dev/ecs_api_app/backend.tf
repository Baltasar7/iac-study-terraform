terraform {
  backend "s3" {
    bucket = "dev-tfstate-aws-iac-study"
    key = "ecs_api_app/teffaform.tfstate"
    region = "us-east-1"
  }
}
