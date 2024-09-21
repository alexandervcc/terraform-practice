variable "instance-type" {
  type    = string
  default = "t3.micro"
}

variable "instance-keypair" {
  type    = string
  default = "terraform-key-1"
}

variable "private-instance-count" {
  type    = number
  default = 1
}

variable "ec2-bastion-name" {
  type    = string
  default = "ec2-bastion"
}

variable "ec2-private-name" {
  type    = string
  default = "ec2-private"
}
