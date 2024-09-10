# HTTP
resource "aws_security_group" "ec2-http-public" {
  name        = "public-http"
  description = "Allow public http"
}

resource "aws_vpc_security_group_ingress_rule" "ingress-http-ip4" {
  security_group_id = aws_security_group.ec2-http-public.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow-all-traffic-ipv4" {
  security_group_id = aws_security_group.ec2-http-public.id
  from_port         = 0
  to_port           = 0
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# SSH
resource "aws_security_group" "ec2-ssh" {
  name        = "public-ssh"
  description = "Allow public ssh"
}

resource "aws_vpc_security_group_ingress_rule" "ingress-ssh-ip4" {
  security_group_id = aws_security_group.ec2-ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
