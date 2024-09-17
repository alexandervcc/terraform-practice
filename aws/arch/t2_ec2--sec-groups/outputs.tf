/*
For a single instance, without count config.

output "instance_public_ip" {
  description = "EC2 instance public IP."
  value       = aws_instance.ec2_http_server.public_ip
}

output "intance_public_dns" {
  description = "EC2 instance public DNS"
  value       = aws_instance.ec2_http_server.public_dns
}
*/

# List
output "for-list-instances" {
  value = [for instance in aws_instance.ec2_http_server : instance.public_dns]
}

# Map 
output "for-map-instaces" {
  value = {
    for instance in aws_instance.ec2_http_server : instance.id => instance.public_dns
  }
}

output "for-map-advanced-instances" {
  # count: index => number
  # for_each: index => key/value of index

  value = {
    for index, instance in aws_instance.ec2_http_server : index => instance.public_dns
  }
}

output "for-splat-operator-instances" {
  # Splat operator does only work for `count`, but not `for_each`
  # value = aws_instance.ec2_http_server[*].public_dns
  value = "default for `for_each`"
}
