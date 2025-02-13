data "aws_ami" "centos" {
  owners = ["973714476881"]
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
}

data "aws_security_group" "launch-wizard-1" {
  name = "launch-wizard-1"
}

variable "components"
default = {
  frontend = {
    name          = "frontend"
    Instance_type = "t3.small"
  }
  mongodb = {
    name          = "mongodb"
    Instance_type = "t3.small"
  }
  catalogue = {
    name          = "catalogue"
    Instance_type = "t3.small"
  }
  redis = {
    name          = "redis"
    Instance_type = "t3.small"
  }
  user = {
    name          = "user"
    Instance_type = "t3.small"
  }
  cart = {
    name          = "cart"
    Instance_type = "t3.small"
  }
  mysql = {
    name          = "mysql"
    Instance_type = "t3.small"
  }
  shipping = {
    name          = "shipping"
    Instance_type = "t3.small"
  }
  rabbitmq = {
    name          = "rabbitmq"
    Instance_type = "t3.small"
  }
  payment = {
    name          = "payment"
    Instance_type = "t3.small"
  }


resource "aws_instance" "instance" {
  for_each    = var.components
  ami   = data.aws_ami.centos.image_id
  instance_type = each.value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.launch-wizard-1.id]

  tags = {
    Name = each.value["name"]
    }
}

//
# resource "aws_route53_record" "record" {
#   for_each    = var.components
#   zone_id = "Z0850283ZZAF9MM79867"
#   name    = ${each.value["name"]}saikumar22.store
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance[each.value["name"]].private_ip]
# }


# resource "aws_instance" "mongodb" {
#   ami = data.aws_ami.centos.image_id
#   instance_type = var.Instance_type
#   vpc_security_group_ids = [data.aws_security_group.launch-wizard-1.id]
#
#   tags = {
#     Name = "mongodb"
#     }
# }
#
# resource "aws_route53_record" "mongodb" {
#   zone_id = "Z0850283ZZAF9MM79867"
#   name    = "mongodb.saikumar22.store"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.mongodb.private_ip]
# }
#
# resource "aws_instance" "catalogue" {
#   ami = data.aws_ami.centos.image_id
#   instance_type = var.Instance_type
#   vpc_security_group_ids = [data.aws_security_group.launch-wizard-1.id]
#
#   tags = {
#     Name = "catalogue"
#     }
# }
#
# resource "aws_route53_record" "catalogue" {
#   zone_id = "Z0850283ZZAF9MM79867"
#   name    = "catalogue.saikumar22.store"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.catalogue.private_ip]
# }
#
# resource "aws_instance" "redis" {
#   ami = data.aws_ami.centos.image_id
#   instance_type = var.Instance_type
#   vpc_security_group_ids = [data.aws_security_group.launch-wizard-1.id]
#
#   tags = {
#     Name = "redis"
#     }
# }
#
# resource "aws_route53_record" "redis" {
#   zone_id = "Z0850283ZZAF9MM79867"
#   name    = "redis.saikumar22.store"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.redis.private_ip]
# }
#
# resource "aws_instance" "user" {
#   ami = data.aws_ami.centos.image_id
#   instance_type = var.Instance_type
#   vpc_security_group_ids = [data.aws_security_group.launch-wizard-1.id]
#
#   tags = {
#     Name = "user"
#     }
# }
#
# resource "aws_route53_record" "user" {
#   zone_id = "Z0850283ZZAF9MM79867"
#   name    = "user.saikumar22.store"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.user.private_ip]
# }
#
# resource "aws_instance" "cart" {
#   ami = data.aws_ami.centos.image_id
#   instance_type = var.Instance_type
#   vpc_security_group_ids = [data.aws_security_group.launch-wizard-1.id]
#
#   tags = {
#     Name = "cart"
#     }
# }
#
# resource "aws_route53_record" "cart" {
#   zone_id = "Z0850283ZZAF9MM79867"
#   name    = "cart.saikumar22.store"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.cart.private_ip]
# }
#
# resource "aws_instance" "mysql" {
#   ami = data.aws_ami.centos.image_id
#   instance_type = var.Instance_type
#   vpc_security_group_ids = [data.aws_security_group.launch-wizard-1.id]
#
#   tags = {
#     Name = "mysql"
#     }
# }
#
# resource "aws_route53_record" "mysql" {
#   zone_id = "Z0850283ZZAF9MM79867"
#   name    = "mysql.saikumar22.store"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.mysql.private_ip]
# }
#
# resource "aws_instance" "shipping" {
#   ami = data.aws_ami.centos.image_id
#   instance_type = var.Instance_type
#   vpc_security_group_ids = [data.aws_security_group.launch-wizard-1.id]
#
#   tags = {
#     Name = "shipping"
#     }
# }
#
# resource "aws_route53_record" "shipping" {
#   zone_id = "Z0850283ZZAF9MM79867"
#   name    = "shipping.saikumar22.store"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.shipping.private_ip]
# }
#
# resource "aws_instance" "rabbitmq" {
#   ami = data.aws_ami.centos.image_id
#   instance_type = var.Instance_type
#   vpc_security_group_ids = [data.aws_security_group.launch-wizard-1.id]
#
#   tags = {
#     Name = "rabbitmq"
#     }
# }
#
# resource "aws_route53_record" "rabbitmq" {
#   zone_id = "Z0850283ZZAF9MM79867"
#   name    = "rabbitmq.saikumar22.store"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.rabbitmq.private_ip]
# }
#
# resource "aws_instance" "payment" {
#   ami = data.aws_ami.centos.image_id
#   instance_type = var.Instance_type
#   vpc_security_group_ids = [data.aws_security_group.launch-wizard-1.id]
#
#   tags = {
#     Name = "payment"
#     }
# }
#
# resource "aws_route53_record" "payment" {
#   zone_id = "Z0850283ZZAF9MM79867"
#   name    = "payment.saikumar22.store"
#   type    = "A"
#   ttl     = 30
#   records = [aws_instance.payment.private_ip]
# }
