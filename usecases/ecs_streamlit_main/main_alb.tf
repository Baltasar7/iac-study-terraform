resource "aws_lb" "ecs_streamlit" {
  name = "${var.stage}-ecs-streamlit-${var.iactool}"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb.id]
  subnets = data.aws_subnets.public.ids
}

resource "aws_lb_target_group" "ecs_streamlit" {
  name = "${var.stage}-ecs-streamlit-${var.iactool}"
  port = 8501
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = data.aws_vpc.this.id
  health_check {
    enabled = true
    path = "/_stcore/health"
    port = "traffic-port"
    protocol = "HTTP"
    matcher = "200-399"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "http_redirect" {
  load_balancer_arn = aws_lb.ecs_streamlit.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.ecs_streamlit.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.streamlit.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_streamlit.arn
  }
}