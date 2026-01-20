variable "cost_thresholds" {
  description = "CloudWatchアラームを作成するためのUSD建てのコスト閾値のリスト。"
  type        = list(string)
  default     = ["5", "10", "20", "30", "50", "100"]
}

variable "alarm_prefix" {
  description = "CloudWatchアラーム名のプレフィックス。"
  type        = string
  default     = "MonthlyBillingAlarm"
}
