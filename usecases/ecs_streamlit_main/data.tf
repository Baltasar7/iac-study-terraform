data "aws_region" "current" {}

data "aws_iam_policy_document" "ecs_task_execution_assume_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      identifiers = [
        "ecs-tasks.amazonaws.com"
      ]
      type = "Service"
    }
  }
}
data "aws_iam_policy" "managed_ecs_task_execution" {
  name = "AmazonECSTaskExecutionRolePolicy"
}
data "aws_iam_policy_document" "ecs_task_execution" {
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameters",
      "ssm:Getparameter",
    ]
    resources = [
      data.aws_ssm_parameter.aws_access_key_id.arn,
      data.aws_ssm_parameter.aws_secret_access_key.arn,
      data.aws_ssm_parameter.aws_region.arn,
      data.aws_ssm_parameter.aws_default_region.arn,
      data.aws_ssm_parameter.claude3_inference_profile_apne1_arn.arn,
      data.aws_ssm_parameter.claude45_inference_profile_apne1_arn.arn,
      data.aws_ssm_parameter.claude45_inference_profile_useast1_arn.arn,
      data.aws_ssm_parameter.knowledge_base_id.arn,
      data.aws_ssm_parameter.default_pinecone_api_key.arn,
      data.aws_ssm_parameter.starter_pinecone_api_key.arn,
    ]
  }
}
data "aws_iam_policy_document" "ecs_task_assume_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      identifiers = [
        "ecs-tasks.amazonaws.com"
      ]
      type = "Service"
    }
  }
}
data "aws_iam_policy_document" "ecs_task" {
  statement {
    effect = "Allow"
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel",
    ]
    resources = ["*"]
  }
}

data "aws_vpc" "this" {
  filter {
    name = "tag:Name"
    values = [local.vpc_name]
  }
}
data "aws_subnets" "public" {
  filter {
    name = "tag:Name"
    values = [
      "${local.vpc_name}-public-us-east-1a",
      "${local.vpc_name}-public-us-east-1b"
    ]
  }
}

data "aws_ssm_parameter" "aws_access_key_id" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/aws_access_key_id"
}
data "aws_ssm_parameter" "aws_secret_access_key" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/aws_secret_access_key"
}
data "aws_ssm_parameter" "aws_region" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/aws_region"
}
data "aws_ssm_parameter" "aws_default_region" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/aws_default_region"
}
data "aws_ssm_parameter" "claude3_inference_profile_apne1_arn" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/claude3_inference_profile_apne1_arn"
}
data "aws_ssm_parameter" "claude45_inference_profile_apne1_arn" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/claude45_inference_profile_apne1_arn"
}
data "aws_ssm_parameter" "claude45_inference_profile_useast1_arn" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/claude45_inference_profile_useast1_arn"
}
data "aws_ssm_parameter" "knowledge_base_id" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/knowledge_base_id"
}
data "aws_ssm_parameter" "default_pinecone_api_key" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/default_pinecone_api_key"
}
data "aws_ssm_parameter" "starter_pinecone_api_key" {
  name = "/ecs-streamlit-${var.iactool}/${var.stage}/starter_pinecone_api_key"
}

data "aws_ecr_repository" "ecs_streamlit" {
  name = "${var.stage}-streamlit-${var.iactool}"
}