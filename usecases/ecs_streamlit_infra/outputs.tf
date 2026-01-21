output "vpc_id" {
  value = module.vpc.vpc_id
}
output "public_subnets" {
  value = module.vpc.public_subnets
}
output "ecr_repository_url" {
  value = aws_ecr_repository.ecs_streamlit.repository_url
}
output "acm_certificate_arn" {
  value = aws_acm_certificate.streamlit.arn
}
