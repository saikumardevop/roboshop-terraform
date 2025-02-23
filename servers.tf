# module "servers" {
#   for_each = var.components
#
#   source         = "./module"
#   component_name = each.value["name"]
#   env   = var.env
#   instance_type  = each.value["instance_type"]
#   password = lookup(each.value, "password", "null"


resource "aws_instance" "instance" {
  for_each = var.components
  ami                    = data.aws_ami.centos.image_id
  instance_type          = each.value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.launch-wizard-5.id]

  tags = {
    Name = each.key
    # Name =  each.value["name"]

  }
}

resource "null_resource" "provisioner" {

  depends_on = [aws_instance.instance, aws_route53_record.records]
  for_each   = var.components
  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.instance[each.value["name"]].private_ip
    }

    inline = [
      "rm -rf roboshop-shell1",
      "git clone https://github.com/saikumardevop/roboshop-shell1.git",
      "cd roboshop-shell1",
      "sudo bash ${each.value["name"]}.sh ${each.value["password"]}"
    ]
  }
}


resource "aws_route53_record" "records" {
  for_each       = var.components
  zone_id        = "Z082431210MK90HJCBQI2"
  name           = "${each.value["name"]}-dev.saikumar22.store"
  type           = "A"
  ttl            = 30
  records        = [aws_instance.instance[each.value["name"]].private_ip]
}

