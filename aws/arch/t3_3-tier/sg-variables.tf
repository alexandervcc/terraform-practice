variable "sg-bastion-name" {
  default = "sec-grp--public-bastion"
  type = string
}

variable "sg-bastion-description" {
  default = "SG with only SSH port open for everybody, and all egress port allowed."
  type = string
}

variable "sg-private-name" {
  default = "sec-grp--private-ec2-instances"
  type = string
}

variable "sg-private-description" {
  default = "SG for EC2 instances to be located in the private subnet."
  type = string
}
