resource "aws_cloudwatch_metric_alarm" "friends_capstone_CPUUtilization" {
  alarm_name          = "friends-capstone-CPUUtilization"
  alarm_description   = "This alarm helps to monitor consistent high CPU utilization. CPU utilization measures non-idle time. Consider using [Enhanced Monitoring](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.OS.Enabling.html) or [Performance Insights](https://aws.amazon.com/rds/performance-insights/) to review which [wait time](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring-Available-OS-Metrics.html) is consuming the most of the CPU time (`guest`, `irq`, `wait`, `nice`, etc) for MariaDB, MySQL, Oracle, and PostgreSQL. Then evaluate which queries consume the highest amount of CPU. If you cannot tune your workload, consider moving to a larger DB instance class."
  actions_enabled     = true

  alarm_actions       = [
    "arn:aws:sns:us-west-2:255945442255:friends-capstone-alarm-slack",
    "arn:aws:sns:us-west-2:255945442255:Default_CloudWatch_Alarms_Topic"
  ]

  metric_name         = "friends-capstone-CPUUtilization"
  namespace           = "AWS/RDS"
  statistic           = "Average"

  dimensions = {
    Name  = "DBInstanceIdentifier"
    Value = "friendscapstonerds"
  }

  period              = 60
  evaluation_periods  = 5
  datapoints_to_alarm = 5
  threshold           = 90
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "breaching"
}

resource "aws_cloudwatch_metric_alarm" "friends_capstone_FreeStorageSpace" {
  alarm_name          = "friends-capstone-FreeStorageSpace"
  alarm_description   = "friends-capstone-FreeStorageSpace. This alarm watches for a low amount of available storage space. Consider scaling up your database storage if you frequently approach storage capacity limits. Include some buffer to accommodate unforeseen increases in demand from your applications. Alternatively, consider enabling RDS storage auto scaling. Additionally, consider freeing up more space by deleting unused or outdated data and logs. For further information, check [RDS run out of storage document](https://repost.aws/knowledge-center/rds-out-of-storage) and [PostgreSQL storage issues document](https://repost.aws/knowledge-center/diskfull-error-rds-postgresql)."
  actions_enabled     = true

  alarm_actions       = [
    "arn:aws:sns:us-west-2:255945442255:friends-capstone-alarm-slack",
    "arn:aws:sns:us-west-2:255945442255:Default_CloudWatch_Alarms_Topic"
  ]

  metric_name         = "friends-capstone-FreeStorageSpace"
  namespace           = "AWS/RDS"
  statistic           = "Average"

  dimensions = {
    Name  = "DBInstanceIdentifier"
    Value = "friendscapstonerds"
  }

  period              = 60
  evaluation_periods  = 5
  datapoints_to_alarm = 5
  threshold           = 10
  comparison_operator = "LessThanThreshold"
  treat_missing_data  = "breaching"
}