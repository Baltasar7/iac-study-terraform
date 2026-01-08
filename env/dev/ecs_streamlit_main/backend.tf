terraform {
  backend "s3" {
    bucket = "dev-tfstate-aws-iac-study"
    key = "ecs_streamlit_main/teffaform.tfstate"
    region = "us-east-1"
  }
}
