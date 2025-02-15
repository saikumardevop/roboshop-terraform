resource "aws_instance" "instance" {
  for_each               = var.components
  ami                    = data.aws_ami.centos.image_id
  instance_type          = each.value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.launch-wizard-1.id]

  tags = {
    Name = each.value["name"]
  }
}

resource "aws_route53_record" "record" {
  for_each              = var.components
  zone_id     = "Z0850283ZZAF9MM79867"
  name        = "${each.value["name"]}.saikumar22.store"
  type        = "A"
  ttl         = 30
  records     = [aws_instance.instance[each.value["name"]].private_ip]
}