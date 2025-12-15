terraform {
    required_version = "1.14.2"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "6.26.0"
        }
    }
    backend "s3" {
        bucket = "dev-tfstate-aws-iac-study"
        key = "dev/terraform.tfstate"
        region = "us-east-1"
    }
}

provider "aws" {
    region = "us-east-1"
    profile = "admin"
}