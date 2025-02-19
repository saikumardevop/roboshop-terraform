terraform {
  backend "s3" {
    bucket = "terraform-d45"
    key = "roboshop/dev/terraform.tfstate"
    region = "us-east-1"
  }
}