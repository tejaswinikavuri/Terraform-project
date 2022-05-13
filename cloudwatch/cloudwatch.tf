resource "aws_cloudwatch_metric_alarm" "foobar" {
  alarm_name                = "terraform-test-foobar5"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
}
resource "aws_cloudwatch_log_group" "lg" {
name = "lg"
}

resource "aws_cloudwatch_log_metric_filter" "CloudWatch" {
  name           = "MyAppAccessCount"
  pattern        = ""
  log_group_name = aws_cloudwatch_log_group.lg.name

  metric_transformation {
    name      = "CW"
    namespace = "NameSpace"
    value     = "1"
  }

}



resource "aws_cloudwatch_log_group" "CloudWatch1" {
  name = "MyApp/access.log"
}