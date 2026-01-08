variable "stage" {
  type = string
  description = "stage: dev,stg,prd"
}
variable "iactool" {
  type = string
  description = "iac tool: tf(terraform),cdk"
}
variable "vpc_cidr" {
  type = string
  description = "VPCのCIDR。"
}
variable "enable_nat_gateway" {
  type = bool
  description = "NAT Gatewayの利用有無。"
}
variable "one_nat_gateway_per_az" {
  type = bool
  default = false
  description = "AZごとに1つのNAT Gatewayを設置するか。"
}