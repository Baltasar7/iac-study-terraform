resource "aws_acm_certificate" "streamlit" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.stage}-streamlit-cert-${var.iactool}"
  }
}
