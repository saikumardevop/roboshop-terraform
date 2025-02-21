module "servers" {


  source         = "./module"
  component_name = each.value["name"]
  env   = var.env
  instance_type  = each.value["instance_type"]
  password = lookup(each.value, "password", "null")
}