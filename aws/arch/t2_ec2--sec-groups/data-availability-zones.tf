data "aws_availability_zones" "my-azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}
