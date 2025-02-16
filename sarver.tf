data "aws_ami" "centos"{
  owners      = ["973714476881"]
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
}

data "aws_security_group" "launch-wizard-6" {
  name = "launch-wizard-6"
}

# variable "instance_type" {
#   default = "t2.micro"
#   }

variable "components" {
  default ={
    frontend = {
      name          = "frontend"
      instance_type = "t2.micro"
    }
    mongodb = {
      name          = "mongodb"
      instance_type = "t2.micro"
    }
    catalogue = {
      name          = "catalogue"
      instance_type = "t3.medium"
    }
    redis = {
      name          = "redis"
      instance_type = "t3.micro"
    }
    user = {
      name          = "user"
      instance_type = "t3.micro"
    }
    cart = {
      name          = "cart"
      instance_type = "t3.micro"
    }
    mysql = {
      name          = "mysql"
      instance_type = "t3.small"
      password      = "RoboShop@1"
    }
    shipping = {
      name          = "shipping"
      instance_type = "t3.medium"
      password      = "RoboShop@1"
    }
    rabbitmq = {
      name          = "rabbitmq"
      instance_type = "t2.micro"
      password      = "roboshop123"

    }
    payment = {
      name          = "payment"
      instance_type = "t3.micro"
      password      = "roboshop123"
    }
  }
}

resource "aws_instance" "components" {
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
