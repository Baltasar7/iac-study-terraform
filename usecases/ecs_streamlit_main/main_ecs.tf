resource "aws_ecs_cluster" "streamlit" {
  name = "${var.stage}-streamlit-${var.iactool}"
}

resource "aws_ecs_cluster_capacity_providers" "streamlit" {
  capacity_providers = [
    "FARGATE",
  ]
  cluster_name = aws_ecs_cluster.streamlit.name
}

resource "aws_ecs_task_definition" "streamlit" {
  container_definitions = jsonencode(
    values(local.container_definitions)
  )
  track_latest = true
  cpu = "256"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  family = "${var.stage}-streamlit-${var.iactool}"
  memory = "512"
  network_mode = "awsvpc"
  requires_compatibilities = [
    "FARGATE",
  ]
  task_role_arn = aws_iam_role.ecs_task.arn
  skip_destroy = true
}

resource "aws_ecs_service" "streamlit" {
  cluster = aws_ecs_cluster.streamlit.arn
  desired_count = 0
  enable_execute_command = true
  health_check_grace_period_seconds = 300
  launch_type = "FARGATE"
  name = "${var.stage}-streamlit-${var.iactool}"
  task_definition = aws_ecs_task_definition.streamlit.arn

  deployment_circuit_breaker {
    enable = true
    rollback = false
  }

  load_balancer {
    container_name = local.container_definitions.streamlit.name
    container_port = 8501
    target_group_arn = aws_lb_target_group.ecs_streamlit.arn
  }

  network_configuration {
    security_groups = [
      aws_security_group.ecs_instance.id
    ]
    subnets = data.aws_subnets.public.ids
    assign_public_ip = true
  }

  lifecycle {
    ignore_changes = [ 
      desired_count
    ]
  }
}