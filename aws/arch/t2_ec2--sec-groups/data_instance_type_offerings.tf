data "aws_ec2_instance_type_offerings" "my-instance-types" {
  for_each = toset(data.aws_availability_zones.my-azones.names)

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

output "supported-azones-by-instance-type" {
  value = keys({
    for az, details in data.aws_ec2_instance_type_offerings.my-instance-types :
    az => details.instance_types if length(details.instance_types) != 0
  })
}

