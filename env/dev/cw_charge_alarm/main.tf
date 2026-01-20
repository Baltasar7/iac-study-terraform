module "cw_charge_alarm" {
  source = "../../../usecases/cw_charge_alarm"

  cost_thresholds    = [5, 10, 20, 30, 50, 100]
  alarm_prefix       = "DevMonthlyBillingAlarm"
}
