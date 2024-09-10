resource "aws_instance" "ec2_http_server" {
  ami           = data.aws_ami.latest-aws-linux.id
  instance_type = var.instance_type
  user_data     = file("${path.module}/../scripts/ec2-http-server.sh")
  key_name      = var.instance_key_pair

  vpc_security_group_ids = [
    aws_security_group.ec2-http-public.id,
    aws_security_group.ec2-ssh.id
  ]
}
