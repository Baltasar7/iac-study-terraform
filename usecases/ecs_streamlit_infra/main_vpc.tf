data "aws_availability_zones" "current" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "6.5.1"

  name = "${var.stage}-vpc-streamlit-${var.iactool}"
  cidr = var.vpc_cidr

  azs = slice(data.aws_availability_zones.current.names, 0, 2)
  public_subnets = [
    cidrsubnet(var.vpc_cidr, 4, 0),
    cidrsubnet(var.vpc_cidr, 4, 1)
  ]
  intra_subnets = [
    cidrsubnet(var.vpc_cidr, 4, 4),
    cidrsubnet(var.vpc_cidr, 4, 5)
  ]
  private_subnets = var.enable_nat_gateway ? [
    cidrsubnet(var.vpc_cidr, 4, 8),
    cidrsubnet(var.vpc_cidr, 4, 9)
  ] : []

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = (
    var.enable_nat_gateway
    ? (var.one_nat_gateway_per_az ? false : true)
    : false
  )
  one_nat_gateway_per_az = (
    var.enable_nat_gateway
    ? var.one_nat_gateway_per_az
    : false
  )

  manage_default_security_group = true
  default_security_group_ingress = []
  default_security_group_egress = []
}