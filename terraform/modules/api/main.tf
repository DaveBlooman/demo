provider "aws" {
  region = "eu-west-1"
}

resource "aws_launch_configuration" "demo-ASG-LC" {
  name_prefix          = "${var.lc_prefix}"
  image_id             = "${var.ami_id}"
  instance_type        = "${var.inst_size}"
  iam_instance_profile = "${var.iam_profile}"
  key_name             = "${var.ssh_key}"
  security_groups      = ["${var.sec_groups}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "demo-ASG" {
  availability_zones   = ["${var.a_z}"]
  vpc_zone_identifier  = ["${var.subnets}"]
  name                 = "${var.asg_name}"
  load_balancers       = ["${aws_elb.demo-elb.name}"]
  health_check_type    = "ELB"
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  desired_capacity     = "${var.des_size}"
  force_delete         = true
  launch_configuration = "${aws_launch_configuration.demo-ASG-LC.name}"

  tag {
    key                 = "environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "${var.name}"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "demo-asg-scaleup" {
  name                   = "demo-asg-scaleup"
  scaling_adjustment     = "${var.scaleup}"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.demo-ASG.name}"
}

resource "aws_autoscaling_policy" "demo-asg-scaledown" {
  name                   = "demo-asg-scaledown"
  scaling_adjustment     = "${var.scaledown}"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.demo-ASG.name}"
}
