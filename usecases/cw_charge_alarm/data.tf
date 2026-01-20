data "aws_ssm_parameter" "sns_email_address" {
  name            = aws_ssm_parameter.cw_billing_alarms_sns_email_address.name
  with_decryption = true
}