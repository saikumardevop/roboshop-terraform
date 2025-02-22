data "aws_ami" "centos" {
  owners = ["522814721008"]
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
}

data "aws_security_group" "launch-wizard-5" {
  name = "launch-wizard-5"
}