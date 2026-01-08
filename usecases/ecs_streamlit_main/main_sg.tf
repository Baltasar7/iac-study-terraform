resource "aws_security_group" "alb" {
  name = "${var.stage}-streamlit-alb-${var.iactool}"
  vpc_id = data.aws_vpc.this.id
}

resource "aws_security_group" "ecs_instance" {
  name = "${var.stage}-streamlit-ecs-instance-${var.iactool}"
  vpc_id = data.aws_vpc.this.id
}

resource "aws_vpc_security_group_ingress_rule" "lb_from_http" {
  ip_protocol = "tcp"
  security_group_id = aws_security_group.alb.id
  from_port = 80
  to_port = 80
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "lb_to_ecs_instance" {
  ip_protocol = "tcp"
  security_group_id = aws_security_group.alb.id
  from_port = 8501
  to_port = 8501
  referenced_security_group_id = aws_security_group.ecs_instance.id
}

resource "aws_vpc_security_group_ingress_rule" "ecs_instance_from_lb" {
  ip_protocol = "tcp"
  security_group_id = aws_security_group.ecs_instance.id
  from_port = 8501
  to_port = 8501
  referenced_security_group_id = aws_security_group.alb.id
}

resource "aws_vpc_security_group_egress_rule" "ecs_instance_to_https" {
  ip_protocol = "tcp"
  security_group_id = aws_security_group.ecs_instance.id
  from_port = 443
  to_port = 443
  cidr_ipv4 = "0.0.0.0/0"
}