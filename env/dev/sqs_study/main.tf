module "sqs_module_test" {
  source = "../../../usecases/sqs_study"
  stage = "dev"
  queue_name_suffix = "sqs-test"
  sqs_queue_visibility_timeout_seconds = 60
}
module "sqs_module_test2" {
  source = "../../../usecases/sqs_study"
  stage = "dev"
  queue_name_suffix = "sqs-test2"
}

output "sqs_queue_url" {
  value = module.sqs_module_test.sqs_queue_url
}