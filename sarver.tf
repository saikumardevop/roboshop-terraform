data "aws_ami" "centos"{
  owners      = ["973714476881"]
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
}

resource "aws_instance" "frontend" {
  ami           = "ami-0b4f379183e5706b9"
  instance_type = "t2.micro"

  tags = {
    Name = "frontend"
  }
}
output "frontend" {
  value = aws_instance.frontend.public_ip
}