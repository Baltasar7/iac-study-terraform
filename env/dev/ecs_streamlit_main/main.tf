module "ecs_streamlit_main" {
  source = "../../../usecases/ecs_streamlit_main"
  stage = "dev"
  iactool = "tf"
}