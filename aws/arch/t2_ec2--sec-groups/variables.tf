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
  type        = string
  default     = "terraform-keys"
}

# Instance type list
variable "instance_type_list" {
  description = "EC2 instance type list"
  type        = list(string)
  default     = ["t3.micro", "t2.micro"]
}

# Instance type map
variable "instance_type_map" {
  description = "EC2 instance type map"
  type        = map(string)
  default = {
    qa  = "t2.micro",
    dev = "t3.micro",
    prod  = "t3.micro"
  }
}
