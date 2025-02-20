variable "env" {}
variable "components" {
  frontend = {
    name          = "frontend"
    instance_type = "t3.micro"
  }
  mongodb = {
    name          = "mongodb"
    instance_type = "t3.micro"
  }
}