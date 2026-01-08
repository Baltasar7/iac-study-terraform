resource "aws_cloudwatch_log_group" "ecs_streamlit" {
  name = "/${var.stage}/ecs/streamlit-${var.iactool}"
  retention_in_days = 90
}