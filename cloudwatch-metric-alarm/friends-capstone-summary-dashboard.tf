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
