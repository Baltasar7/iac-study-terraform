module "sqs_module_test" {
  source = "../../../usecases/sqs_study"
  stage = "dev"
  queue_name_suffix = "sqs-test"
}

output "sqs_queue_url" {
  value = module.sqs_module_test.sqs_queue_url
}