resource "aws_cloudwatch_event_rule" "Evening_routine" {
    name = "Evening-routine"
    description = "Plannification du soir"
    schedule_expression = "cron(32 12 ? * MON-FRI *)"
}

resource "aws_cloudwatch_event_rule" "Morning_routine" {
    name = "Morning-routine"
    description = "Plannification du matin"
    schedule_expression = "cron(0 8 ? * MON-FRI *)"
}

resource "aws_cloudwatch_event_target" "shutdown_asg" {
    arn = aws_lambda_function.test_asg_final.arn
    rule = aws_cloudwatch_event_rule.Evening_routine.id
}