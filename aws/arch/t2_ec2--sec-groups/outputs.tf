output "instance_public_ip" {
  description = "EC2 instance public IP."
  value       = aws_instance.ec2_http_server.public_ip
}

output "intance_public_dns" {
  description = "EC2 instance public DNS"
  value       = aws_instance.ec2_http_server.public_dns
}
