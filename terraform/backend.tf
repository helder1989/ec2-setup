terraform {
  backend "s3" {
    bucket      = "ec2-setup-terraform-assests"
    key         = "terraform.tfstate"
    region      = "us-east-1"
    encrypt     = true
  }
}

provider "aws" {
    profile = "default"
    region  = "us-east-1"
}