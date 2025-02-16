resource "aws_instance" "instance" {
  for_each               = var.components
  ami                    = data.aws_ami.centos.image_id
  instance_type          = each.value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.launch-wizard-6.id]

  tags = {
    Name = each.value ["name"]
  }
}

resource "aws_route53_record" "records" {
  for_each         = var.components
  zone_id          = "Z07633651VJKTEQ867N3J"
  name             = "${each.value["name"]}-dev.rajasekhar72.store"
  type             = "A"
  ttl              = 30
  records          = [aws_instance.instance[each.value["name"]].private_ip]
}
