terraform {
  backend "s3" {
    bucket = "dev-tfstate-aws-iac-study"
    key = "ecs_streamlit_infra/teffaform.tfstate"
    region = "us-east-1"
  }
}
