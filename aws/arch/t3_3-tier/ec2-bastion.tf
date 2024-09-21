module "ec2-bastion-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.0"

  name = "${var.environment}-${var.ec2-bastion-name}"

  instance_type = var.instance-type
  key_name      = var.instance-keypair
  ami           = data.aws_ami.latest-aws-linux.id

  subnet_id = module.aws-vpc.public_subnets[0]

  vpc_security_group_ids = [module.sg-public-bastion.security_group_id]

  depends_on = [module.aws-vpc]
}
