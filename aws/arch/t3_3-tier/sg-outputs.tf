output "sg-bastion-id" {
  value = module.sg-public-bastion.security_group_id
}

output "sg-private-id" {
  value = module.sg-private.security_group_id
}
