resource "aws_sns_topic" "billing_alarm_topic" {
  name = "billing-alarm-topic"
}

resource "aws_sns_topic_subscription" "billing_alarm_subscription" {
  topic_arn = aws_sns_topic.billing_alarm_topic.arn
  protocol  = "email"
  endpoint  = var.notification_email
}

resource "aws_cloudwatch_metric_alarm" "billing_alarms" {
  for_each            = toset(var.cost_thresholds)
  alarm_name          = "${var.alarm_prefix}-${each.key}USD"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "21600" # 6 hours (6 * 3600 seconds)
  statistic           = "Maximum"
  threshold           = each.key
  alarm_description   = "Alarm when AWS estimated charges exceed ${each.key} USD"
  treat_missing_data  = "notBreaching"
  unit                = "USD"

  dimensions = {
    Currency = "USD"
  }

  alarm_actions = [aws_sns_topic.billing_alarm_topic.arn]
  ok_actions    = [aws_sns_topic.billing_alarm_topic.arn]

  # CloudWatch Billing metrics are only available in us-east-1
  provider = aws.us_east_1
}
