resource "aws_instance" "demo_server" {
  ami           = "ami-0c1c30571d2dae5c9"
  instance_type = "t2.micro"

  tags = {
    Name = "konrad-demo-server"
  }
}
