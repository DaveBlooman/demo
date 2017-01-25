variable "ami_id" {
  default = "ami-dc9edeaf"
}

variable "inst_size" {
  default = "c3.xlarge"
}

variable "ssh_key" {
  default = "basekey"
}

variable "environment" {
  default = "production"
}

variable "name" {
  default = "host@demo-asg"
}

variable "lc_prefix" {
  default = "demo-lc"
}

variable "iam_profile" {
  default = "default"
}

variable "sec_groups" {
  default = ""
}

variable "subnets" {
  default = ""
}

variable "asg_name" {
  default = ""
}

variable "min_size" {
  default = ""
}

variable "max_size" {
  default = ""
}

variable "des_size" {
  default = ""
}

variable "a_z" {
  default = ""
}

variable "elb_name" {
  default = ""
}

variable "scaleup" {
  default = ""
}

variable "scaledown" {
  default = ""
}

variable "elb_logs" {
  default = ""
}

variable "elb_prefix_log" {
  default = ""
}

variable "health_check" {
  default = "HTTP:80/"
}

variable "cpu_threshold_high" {
  default = ""
}

variable "cpu_threshold_low" {
  default = ""
}
