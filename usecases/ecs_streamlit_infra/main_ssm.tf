resource "aws_ssm_parameter" "aws_access_key_id" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/aws_access_key_id"
  type = "SecureString"
  value = "uninitialized"
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
resource "aws_ssm_parameter" "aws_secret_access_key" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/aws_secret_access_key"
  type = "SecureString"
  value = "uninitialized"
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
resource "aws_ssm_parameter" "aws_region" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/aws_region"
  type = "SecureString"
  value = "uninitialized"
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
resource "aws_ssm_parameter" "aws_default_region" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/aws_default_region"
  type = "SecureString"
  value = "uninitialized"
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
resource "aws_ssm_parameter" "claude3_inference_profile_apne1_arn" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/claude3_inference_profile_apne1_arn"
  type = "SecureString"
  value = "uninitialized"
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
resource "aws_ssm_parameter" "claude45_inference_profile_apne1_arn" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/claude45_inference_profile_apne1_arn"
  type = "SecureString"
  value = "uninitialized"
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
resource "aws_ssm_parameter" "claude45_inference_profile_useast1_arn" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/claude45_inference_profile_useast1_arn"
  type = "SecureString"
  value = "uninitialized"
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
resource "aws_ssm_parameter" "knowledge_base_id" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/knowledge_base_id"
  type = "SecureString"
  value = "uninitialized"
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
resource "aws_ssm_parameter" "default_pinecone_api_key" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/default_pinecone_api_key"
  type = "SecureString"
  value = "uninitialized"
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
resource "aws_ssm_parameter" "starter_pinecone_api_key" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/starter_pinecone_api_key"
  type = "SecureString"
  value = "uninitialized"
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}