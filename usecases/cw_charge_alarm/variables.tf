variable "notification_email" {
  description = "The email address to send CloudWatch alarm notifications to."
  type        = string
}

variable "cost_thresholds" {
  description = "A list of cost thresholds in USD to create CloudWatch alarms for."
  type        = list(number)
  default     = [5, 10, 20, 30, 50, 100]
}

variable "alarm_prefix" {
  description = "A prefix for the CloudWatch alarm names."
  type        = string
  default     = "MonthlyBillingAlarm"
}
