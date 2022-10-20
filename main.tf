resource "aws_budgets_budget" "monthly-budget" {
  name              = "monthly-budget"
  budget_type       = "COST"
  limit_amount      = "100.0"
  limit_unit        = "USD"
  time_period_start = "2022-02-16_00:00"
  time_unit         = "MONTHLY"

}

#########################
#VPC CONFIGURATION
#########################
