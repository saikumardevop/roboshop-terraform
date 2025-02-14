terraform {
  backend "s3" {
    bucket = "terraform-b9"
    key    = "roboshop/dev/terraform.tfstate"
    region = "us-east-1"
  }
}