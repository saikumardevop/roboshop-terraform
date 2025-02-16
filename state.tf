terraform {
  backend "s3" {
    bucket = "terraform-h76"
    key = "roboshop/dev/terraform.tfstate"
    region = "us-east-1"
  }
}