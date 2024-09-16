resource "aws_instance" "ec2_http_server" {
  ami = data.aws_ami.latest-aws-linux.id

  # From explicit string variable
  # instance_type = var.instance_type

  instance_type = var.instance_type_list[0]
  # instance_type = var.instance_type_map["qa"]  

  user_data = file("${path.module}/../scripts/ec2-http-server.sh")
  key_name  = var.instance_key_pair

  vpc_security_group_ids = [
    aws_security_group.ec2-http-public.id,
    aws_security_group.ec2-ssh.id
  ]

  # count: create x instances of this resource
  count = 2

  tags = {
    Name = "Count-${count.index}"
  }
}
