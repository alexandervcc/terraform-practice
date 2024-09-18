data "aws_ec2_instance_type_offerings" "my-instance-types" {
  for_each = toset(["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"])

  location_type = "availability-zone"

  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }

  filter {
    name   = "location"
    values = [each.key]
  }

}

output "instance--us-east-1" {
  value = { for az, type in data.aws_ec2_instance_type_offerings.my-instance-types : az => type.instance_types }
}
