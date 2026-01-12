terraform {
  backend "s3" {
    bucket = "dev-tfstate-aws-iac-study"
    key = "cw_charge_alarm/teffaform.tfstate"
    region = "us-east-1"
  }
}
