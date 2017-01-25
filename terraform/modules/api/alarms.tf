resource "aws_cloudwatch_metric_alarm" "demo-cpu-high" {
  alarm_name          = "demo-cpu-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "System/Linux"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.cpu_threshold_high}"

  alarm_actions = [
    "${aws_autoscaling_policy.demo-asg-scaleup.arn}",
  ]

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.demo-ASG.name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "demo-cpu-low" {
  alarm_name          = "demo-cpu-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "System/Linux"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.cpu_threshold_low}"

  alarm_actions = [
    "${aws_autoscaling_policy.demo-asg-scaledown.arn}",
  ]

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.demo-ASG.name}"
  }
}
