resource "aws_cloudwatch_metric_alarm" "cloudwatch_alarm" {
  # Intent            : "This alarm is used to detect consistent high CPU utilization in order to prevent very high response time and time-outs. If you want to check micro-bursting of CPU utilization you can set a lower alarm evaluation time."
  # Threshold Justification : "Random spikes in CPU consumption may not hamper database performance, but sustained high CPU can hinder upcoming database requests. Depending on the overall database workload, high CPU at your RDS/Aurora instance can degrade the overall performance."

  alarm_name          = "AWS/RDS CPUUtilization DBInstanceIdentifier=friendscapstonerds"
  alarm_description   = "This alarm helps to monitor consistent high CPU utilization. CPU utilization measures non-idle time. Consider using [Enhanced Monitoring](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.OS.Enabling.html) or [Performance Insights](https://aws.amazon.com/rds/performance-insights/) to review which [wait time](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring-Available-OS-Metrics.html) is consuming the most of the CPU time (`guest`, `irq`, `wait`, `nice`, etc) for MariaDB, MySQL, Oracle, and PostgreSQL. Then evaluate which queries consume the highest amount of CPU. If you cannot tune your workload, consider moving to a larger DB instance class."
  actions_enabled     = false
  ok_actions          = []
  alarm_actions       = []
  insufficient_data_actions = []
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  statistic           = "Average"
  period              = 60
  dimensions = {
    DBInstanceIdentifier = "friendscapstonerds"
  }                  
  evaluation_periods  = 5
  datapoints_to_alarm = 5
  threshold           = 90
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "breaching"
}