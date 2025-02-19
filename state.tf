terraform {
  backend "s3" {
    bucket = "terraform-v78"
    key = "roboshop/dev/terraform.tfstate"
    region = "us-east-1"
  }
}