provider "aws" {
  region = "us-east-1"
  profile = "admin"
  default_tags {
    tags = {
      Terraform = "true"
      STAGE = "dev"
      MODUlE = "ecs_api_app"
    }
  }
}
provider "aws" {
  alias = "ap_northeast_1"
  region = "ap-northeast-1"
  profile = "admin"
  default_tags {
    tags = {
      Terraform = "true"
      STAGE = "dev"
      MODUlE = "ecs_api_app"
    }
  }
}
