resource "aws_cloudwatch_metric_alarm" "friends_capstone_summary_CPUUtilization" {
  alarm_name          = "friends-capstone-summary-CPUUtilization"
  alarm_description   = "This alarm helps you detect a high CPU utilization of the ECS service. If there is no ongoing ECS deployment, a maxed-out CPU utilization might indicate a resource bottleneck or application performance problems. To troubleshoot, you can increase the CPU limit."
  actions_enabled     = true

  alarm_actions       = [
    "arn:aws:sns:us-west-2:255945442255:friends-capstone-alarm-slack",
    "arn:aws:sns:us-west-2:255945442255:Default_CloudWatch_Alarms_Topic"
  ]

  metric_name         = "friends-capstone-summary-CPUUtilization"
  namespace           = "AWS/ECS"
  statistic           = "Average"

  dimensions = {
    ServiceName = "friends-capstone-crud-api-service"
    ClusterName = "friends-capstone-cluster"
  }

  period              = 300
  evaluation_periods  = 5
  datapoints_to_alarm = 5
  threshold           = 100
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "breaching"
}