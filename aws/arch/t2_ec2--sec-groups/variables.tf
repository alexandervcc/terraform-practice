variable "aws_region" {
  description = "AWS region allocate resources."
  type        = string
  default     = "us-east-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_key_pair" {
  description = "EC2 key pair"
  type = string
  default = "terraform-keys"
}
