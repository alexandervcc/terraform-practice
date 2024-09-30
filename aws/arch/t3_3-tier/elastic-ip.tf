resource "aws_eip" "bastion-public-static-ip" {
  depends_on = [module.aws-vpc, module.ec2-bastion-instance]

  instance = module.ec2-bastion-instance.id
  domain   = "vpc"

provisioner "local-exec" {
    command     = "echo VPC instance destroyed `date` >> destroy-provisioner.txt"
    working_dir = "output/"
    when = destroy
  }
}
