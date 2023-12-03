resource "aws_cloudwatch_metric_alarm" "friends_capstone_summary_ECS_CPUUtilization" {
  alarm_name          = "friends-capstone-summary-ECS-Card CRUD APIs-CPUUtilization"
  alarm_description   = "This alarm helps you detect a high CPU utilization of the ECS service. If there is no ongoing ECS deployment, a maxed-out CPU utilization might indicate a resource bottleneck or application performance problems. To troubleshoot, you can increase the CPU limit."
  actions_enabled     = true

  alarm_actions       = [
    "arn:aws:sns:us-west-2:255945442255:friends-capstone-alarm-slack",
    "arn:aws:sns:us-west-2:255945442255:Default_CloudWatch_Alarms_Topic"
  ]

  metric_name         = "friends-capstone-summary-ECS-Card CRUD APIs-CPUUtilization"
  namespace           = "AWS/ECS"
  statistic           = "Average"

  dimensions = {
    ServiceName = "friends-capstone-crud-api-service"
    ClusterName = "friends-capstone-cluster"
  }

  period              = 300
  evaluation_periods  = 5
  datapoints_to_alarm = 5
  threshold           = 90
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "friends_capstone_summary_ECS_MemoryUtilization" {
  alarm_name          = "friends-capstone-summary-ECS-Card CRUD APIs-MemoryUtilization"
  alarm_description   = "This alarm is triggered when the memory utilization of the system falls below a predefined threshold."
  actions_enabled     = true

  alarm_actions       = [
    "arn:aws:sns:us-west-2:255945442255:friends-capstone-alarm-slack",
    "arn:aws:sns:us-west-2:255945442255:Default_CloudWatch_Alarms_Topic"
  ]

  metric_name         = "friends-capstone-summary-ECS-Card CRUD APIs-MemoryUtilization"
  namespace           = "."
  statistic           = "Average"

  dimensions = [
    {
      name  = "."
      value = "."
    }
  ]

  period              = 21600
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  threshold           = 10
  comparison_operator = "LessThanThreshold"
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "friends_capstone_summary_RDS_CPUUtilization" {
  alarm_name          = "friends-capstone-summary-RDS-CPUUtilization"
  alarm_description   = "This alarm helps to monitor consistent high CPU utilization. CPU utilization measures non-idle time. Consider using [Enhanced Monitoring](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.OS.Enabling.html) or [Performance Insights](https://aws.amazon.com/rds/performance-insights/) to review which [wait time](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring-Available-OS-Metrics.html) is consuming the most of the CPU time (`guest`, `irq`, `wait`, `nice`, etc) for MariaDB, MySQL, Oracle, and PostgreSQL. Then evaluate which queries consume the highest amount of CPU. If you cannot tune your workload, consider moving to a larger DB instance class."
  actions_enabled     = true

  alarm_actions       = [
    "arn:aws:sns:us-west-2:255945442255:Default_CloudWatch_Alarms_Topic",
    "arn:aws:sns:us-west-2:255945442255:friends-capstone-alarm-slack"
  ]

  metric_name         = "friends-capstone-summary-RDS-CPUUtilization"
  namespace           = "AWS/RDS"
  statistic           = "Average"

  dimensions = {
    Name  = "DBInstanceIdentifier"
    Value = "friendscapstonerds"
  }

  period              = 300
  evaluation_periods  = 5
  datapoints_to_alarm = 5
  threshold           = 90
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "notBreaching"
}
