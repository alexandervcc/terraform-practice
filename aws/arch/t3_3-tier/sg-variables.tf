variable "sg-bastion-name" {
  default = "sg-public-bastion"
  type = string
}

variable "sg-bastion-description" {
  default = "SG with only SSH port open for everybody, and all egress port allowed."
  type = string
}
