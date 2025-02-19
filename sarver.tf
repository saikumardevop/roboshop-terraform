# module "servers" {
#   for_each = var.components
#
#   source         = "./module"
#   component_name = each.value["name"]
#   env   = var.env
#   instance_type  = each.value["instance_type"]
#   password = lookup(each.value, "password", "null")
# }


data "aws_ami" "centos" {
  owners = ["973714476881"]
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
}

data "aws_security_group" "launch-wizard-6" {
  name = "launch-wizard-6"
}

resource "aws_instance" "instance" {
  ami                    = data.aws_ami.centos.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.launch-wizard-6.id]

  tags = {
    Name = local.name
  }
}

resource "aws_route53_record" "records" {
  zone_id  = "Z07633651VJKTEQ867N3J"
  name     = "${var.component_name}-dev.rajasekhar72.store"
  type     = "A"
  ttl      = 30
  records  = [aws_instance.instance.private_ip]
}
