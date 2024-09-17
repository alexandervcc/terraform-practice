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
  # count = 2

  # Create an instance on differente Availability zones
  for_each          = toset(data.aws_availability_zones.my-azones.names)
  availability_zone = each.key

  tags = {
    # NameCount   = "Count-${count.index}",
    Name = "For-Each-${each.key}"
  }
}
