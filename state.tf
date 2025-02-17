terraform {
  backend "s3" {
    bucket = "terraform-g35"
    key    = "roboshop/dev/terrafom.tfstate"
    region = "us-east-1"
  }
}
