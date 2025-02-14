data "aws_ami" "centos" {
  owners = ["973714476881"]
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
}

data "aws_security_group" "launch-wizard-1" {
  name = "launch-wizard-1"
}

variable "components" {
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
      Instance_type = "t3.micro"
    }
    cart = {
      name          = "cart"
      Instance_type = "t3.micro"
    }
    mysql = {
      name          = "mysql"
      Instance_type = "t3.small"
    }
    shipping = {
      name          = "shipping"
      Instance_type = "t3.medium"
    }
    rabbitmq = {
      name          = "rabbitmq"
      Instance_type = "t3.small"
    }
    payment = {
      name          = "payment"
      Instance_type = "t3.small"
    }
  }
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
