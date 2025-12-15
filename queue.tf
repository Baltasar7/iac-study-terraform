resource "aws_sqs_queue" "iac_study_queue" {
    name = "test-queue-tf"
    max_message_size = 2048
    tags = {
        "name" = "test-queue-tf"
    }
}