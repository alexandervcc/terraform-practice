module "ec2-private-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.0"

  name = "${var.environment}-${var.ec2-private-name}"

  instance_type = var.instance-type
  key_name      = var.instance-keypair
  ami           = data.aws_ami.latest-aws-linux.id

  vpc_security_group_ids = [module.sg-private.security_group_id]

  user_data = file("${path.module}/../scripts/ec2-http-server.sh")

  # for_each  = toset(module.aws-vpc.private_subnets)

  # for_each  = local.private_subnets
  # subnet_id = each.value

  for_each  = toset(["0", "1"])
  subnet_id = element(module.aws-vpc.private_subnets, tonumber((each.value)))


  depends_on = [module.aws-vpc]
}
