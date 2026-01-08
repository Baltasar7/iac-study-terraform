locals {
  vpc_name = "${var.stage}-vpc-streamlit-${var.iactool}"
}

locals {
  container_definitions = {
    streamlit = {
      name = "streamlit"
      secrets = [
        {
          name = "AWS_ACCESS_KEY_ID"
          valueFrom = data.aws_ssm_parameter.aws_access_key_id.arn
        },
        {
          name = "AWS_SECRET_ACCESS_KEY"
          valueFrom = data.aws_ssm_parameter.aws_secret_access_key.arn
        },
        {
          name = "AWS_DEFAULT_REGION"
          valueFrom = data.aws_ssm_parameter.aws_default_region.arn
        },
        {
          name = "CLAUDE4.5_INFERENCE_PROFILE_USEAST1_ARN"
          valueFrom = data.aws_ssm_parameter.claude45_inference_profile_useast1_arn.arn
        },
        {
          name = "KNOWLEDGE_BASE_ID"
          valueFrom = data.aws_ssm_parameter.knowledge_base_id.arn
        },
      ]
      essential = true
      image = "${data.aws_ecr_repository.ecs_streamlit.repository_url}:v1.0.0"
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group = aws_cloudwatch_log_group.ecs_streamlit.name
          awslogs-region = data.aws_region.current.region
          awslogs-stream-prefix = "ecs_streamlit"
        }
      }
      portMappings = [
        {
          containerPort = 8501
          hostPort = 8501
          protocol = "tcp"
        },
      ]
    },
  }
}
