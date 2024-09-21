output "ec2-bastion_id" {
  value = module.ec2-bastion-instance.id
}

output "ec2-bastion_public-ip" {
  value = module.ec2-bastion-instance.public_ip
}

output "ec2-private_id" {
  value = [for ec2 in module.ec2-private-instance : ec2.id]
}

output "ec2-private_private-ip" {
  value = [for ec2 in module.ec2-private-instance : ec2.private_ip]
}
