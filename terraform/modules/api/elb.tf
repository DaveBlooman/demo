resource "aws_elb" "demo-elb" {
  name            = "${var.elb_name}"
  subnets         = ["${var.subnets}"]
  security_groups = ["${var.sec_groups}"]

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "${var.health_check}"
  }

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }

  /*access_logs {

  }*/
}
