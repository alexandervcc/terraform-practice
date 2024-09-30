resource "null_resource" "null" {
  depends_on = [module.ec2-bastion-instance]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = aws_eip.bastion-public-static-ip.public_ip
    private_key = file("${path.module}/../keys/terraform-keys-1.pem")
  }

  // Let copy file from machine running terraform to the created/connected resource
  provisioner "file" {
    source      = "../keys/terraform-keys-1.pem"
    destination = "/tmp/xd-keys.pem"
  }

  // Let execute an script/commands on the remote resource after this has been created
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/xd-keys.pem"
    ]
  }

  // Let execute an script/command on the machine running terraform
  provisioner "local-exec" {
    command     = "echo EC2 instance created `date` on VPC ${module.aws-vpc.vpc_id} >> xd-file-creation.txt"
    working_dir = "output/"
    on_failure  = continue
  }

  /*
  provisioner "local-exec" {
    command     = "echo EC2 instance destroyed `date` >> xd-file-destroy.txt"
    working_dir = "output/"
    when = destroy
  }
  */
}

