#!/bin/sh
aws cloudwatch describe-alarms --query 'MetricAlarms[?contains(AlarmName, 'friends')]' --region us-west-2 > ./alarms_backup/alarms_backup.json
cat ./alarms_backup/alarms_backup.json 