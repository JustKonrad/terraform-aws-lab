resource "aws_instance" "demo_server" {
  ami           = "ami-0c1c30571d2dae5c9"
  instance_type = "t2.micro"

  tags = {
    Name = "konrad-demo-server"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web-security-group"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
