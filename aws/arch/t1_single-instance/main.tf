resource "aws_instance" "ec2_http_server" {
  ami           = "ami-09efc42336106d2f2" 
  instance_type = "t2.micro"
  user_data = file("${path.module}/../ec2-http-server.sh")
  tags = {
    "base" : "simple-ec2-instance"
  }
}
