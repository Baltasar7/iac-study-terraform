resource "aws_ssm_parameter" "cw_billing_alarms_sns_email_address" {
  name = "/cw_billing_alarms/sns_email_address"
  description = "CloudWatchアラーム通知の送信先メールアドレス。"
  type = "SecureString"
  value = "uninitialized@example.com"  # このアドレスへのサブスクリプションは、ParameterStoreのemailaddressを手動修正後も"保留中の確認"で残り続けるが、3日後に自動削除される
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "aws_sns_topic" "billing_alarm_topic" {
  name = "billing-alarm-topic"
}

resource "aws_sns_topic_subscription" "billing_alarm_subscription" {
  topic_arn = aws_sns_topic.billing_alarm_topic.arn
  protocol  = "email"
  endpoint  = data.aws_ssm_parameter.sns_email_address.value
}

resource "aws_cloudwatch_metric_alarm" "billing_alarms" {
  for_each            = toset(var.cost_thresholds)
  alarm_name          = "${var.alarm_prefix}-${each.key}USD"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "600"  # AIコスト急増対策で10分毎にチェック。ただし、Billing更新は日に4～8回とのこと
  statistic           = "Maximum"
  threshold           = each.key
  alarm_description   = "AWSの推定料金が${each.key}USDを超過した場合にアラームを発報"
  treat_missing_data  = "ignore"  # データ不足は無視（Alarm維持）。"notBreaching"の場合、データ不足時にOK遷移を通知してしまう

  dimensions = {
    Currency = "USD"
  }

  alarm_actions = [aws_sns_topic.billing_alarm_topic.arn]
  ok_actions    = [aws_sns_topic.billing_alarm_topic.arn]  # 月初にリセットに発火

  # terraformの親モジュールで指定するので不要。この行があると terraform plan で失敗する 
  # provider = aws.us_east_1  # 請求Metricsは全世界分まとめてus-east-1に保存される仕様。Alarmもこのregionに配置する必要あり
}
