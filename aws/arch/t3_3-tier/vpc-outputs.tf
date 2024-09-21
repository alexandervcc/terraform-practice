output "vpc-id" {
  description = "VPC id"
  value       = module.aws-vpc.vpc_id
}

output "vpc-cidr-block" {
  description = "The CIDR block of the VPC"
  value       = module.aws-vpc.vpc_cidr_block
}

output "private-subnets" {
  description = "List of IDs of private subnets"
  value       = module.aws-vpc.private_subnets
}

output "public-subnets" {
  description = "List of IDs of public subnets"
  value       = module.aws-vpc.public_subnets
}

output "nat-public-ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.aws-vpc.nat_public_ips
}