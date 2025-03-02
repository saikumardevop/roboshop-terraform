resource "aws_instance" "instance" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.launch-wizard-5.id]

  tags = {
    Name =  local.name
  }
}

resource "null_resource" "provisioner" {
  count = var.provisioner ? 1:0
  depends_on = [aws_instance.instance, aws_route53_record.records]
  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "root"
      password = "DevOps321"
      host     = aws_instance.instance.private_ip
    }

    inline = [
      "rm -rf roboshop-shell1",
      "git clone https://github.com/saikumardevop/roboshop-shell1.git",
      "cd roboshop-shell1",
      "sudo bash ${var.component_name}.sh ${var.password}"
    ]
  }
}

resource "aws_route53_record" "records" {
  zone_id   = "Z082431210MK90HJCBQI2"
  name      = "${var.component_name}-dev.saikumar22.store"
  type      = "A"
  ttl       = 30
  records   = [aws_instance.instance.private_ip]
}

