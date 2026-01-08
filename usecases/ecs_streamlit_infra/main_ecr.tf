resource "aws_ecr_repository" "ecs_streamlit" {
  name = "${var.stage}-streamlit-${var.iactool}"
}