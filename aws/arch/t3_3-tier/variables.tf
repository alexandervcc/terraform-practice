variable "aws_region" {
  description = "AWS region allocate resources."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "public-subnets" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "private-subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}


