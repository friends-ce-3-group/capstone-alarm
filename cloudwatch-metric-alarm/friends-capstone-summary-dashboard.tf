resource "aws_cloudwatch_metric_alarm" "cloudwatch_alarm" {
  # Intent            : "This alarm is used to detect high CPU utilization for the ECS service. Consistent high CPU utilization can indicate a resource bottleneck or application performance problems."
  # Threshold Justification : "The service metrics for CPU utilization might exceed 100% utilization. However, we recommend that you monitor the metric for high CPU utilization to avoid impacting other services. Set the threshold to about 90-95%. We recommend that you update your task definitions to reflect actual usage to prevent future issues with other services."

  alarm_name          = "AWS/ECS CPUUtilization ServiceName=friends-capstone-crud-api-service ClusterName=friends-capstone-cluster"
  alarm_description   = "This alarm helps you detect a high CPU utilization of the ECS service. If there is no ongoing ECS deployment, a maxed-out CPU utilization might indicate a resource bottleneck or application performance problems. To troubleshoot, you can increase the CPU limit."
  actions_enabled     = false
  ok_actions          = []
  alarm_actions       = []
  insufficient_data_actions = []
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  statistic           = "Average"
  period              = 60
  dimensions = {
    ServiceName = "friends-capstone-crud-api-service"
    ClusterName = "friends-capstone-cluster"
  }                  
  evaluation_periods  = 5
  datapoints_to_alarm = 5
  threshold           = 90
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "breaching"
}

resource "aws_cloudwatch_metric_alarm" "ecs_memory_alarm" {
    #Intent : "This alarm monitors the Memory Utilization of an Amazon ECS (Elastic Container Service) cluster. Memory Utilization is a crucial metric for assessing the memory usage of your containerized applications. High Memory Utilization may indicate potential performance issues or resource constraints within your ECS tasks or services."
    
  alarm_name          = "ECS MemoryUtilization"
  alarm_description   = "This alarm monitors the Memory Utilization of an Amazon ECS (Elastic Container Service) cluster. Memory Utilization is a crucial metric for assessing the memory usage of your containerized applications. High Memory Utilization may indicate potential performance issues or resource constraints within your ECS tasks or services."
  actions_enabled     = true
  alarm_actions       = ["arn:aws:sns:us-west-2:255945442255:Default_CloudWatch_Alarms_Topic"]
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  statistic           = "Average"

  dimensions = {
    # No specific dimensions for ECS MemoryUtilization in this case
  }

  period             = 21600
  evaluation_periods = 1
  datapoints_to_alarm = 1
  threshold          = 0.1
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data = "missing"
}