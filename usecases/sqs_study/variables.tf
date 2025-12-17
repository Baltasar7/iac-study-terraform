variable "stage" {
  type = string
  validation {
    condition = can(regex("^(prd|stg|dev)$", var.stage))
    error_message = "環境名。prd,stg,devのいずれかを指定。"
  }
  description = "ステージの名前。prd,stg,devのいずれかを指定。"
}

variable "queue_name_suffix" {
  type = string
  description = "SQSキューの名前の接尾語。"
}

variable "sqs_queue_visibility_timeout_seconds" {
  type = number
  default = 30
  description = "SQSキューのメッセージの可視性タイムアウト時間。単位は秒。デフォルトは30。"
}

//variable "tags" {
//  
//}