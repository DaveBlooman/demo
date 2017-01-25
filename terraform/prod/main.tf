provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "eu-west-1"
}

resource "aws_iam_instance_profile" "demo-iam-profile" {
  name  = "demo-iam-profile"
  roles = ["${aws_iam_role.demo-iam-role.name}"]
}

resource "aws_iam_role_policy" "demo-policy" {
  name = "demo-policy"
  role = "${aws_iam_role.demo-iam-role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "demo-iam-role" {
  name = "demo-iam-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_security_group" "demo-sg-basic" {
  name   = "demo-sg-basic"
  vpc_id = "vpc-be32d9da"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "demo" {
  source             = "../modules/api"
  ami_id             = "ami-4c98113f"
  inst_size          = "t2.micro"
  ssh_key            = "demo"
  environment        = "production"
  name               = "demoapp"
  lc_prefix          = "demo-lc-"
  iam_profile        = "${aws_iam_instance_profile.demo-iam-profile.name}"
  sec_groups         = "${aws_security_group.demo-sg-basic.id}"
  subnets            = "subnet-bce5f7e5"
  asg_name           = "demo-asg"
  min_size           = "1"
  max_size           = "1"
  des_size           = "1"
  a_z                = "eu-west-1a"
  elb_name           = "demo-elb"
  scaleup            = 10
  scaledown          = -10
  cpu_threshold_high = "80"
  cpu_threshold_low  = "40"
  health_check       = "HTTP:80/health"
}
