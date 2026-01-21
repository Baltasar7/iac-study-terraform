module "ecs_streamlit_infra" {
  source = "../../../usecases/ecs_streamlit_infra"
  stage = "dev"
  iactool = "tf"
  vpc_cidr = "10.0.0.0/16"
  enable_nat_gateway = false
  domain_name = "streamlit.example.com"
}