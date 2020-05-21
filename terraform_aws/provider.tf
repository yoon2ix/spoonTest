provider "aws" {
}

terraform {
 required_version = "0.12.2"

 required_providers {
  aws = ">= 2.62.0"
 }
}


module "vpc" {
 source = "./modules/vpc"

 name = "spoonVPC"
 vpc_cidr = "192.168.0.0/16"

 avail_zones = ["ap-northeast-2a", "ap-northeast-2c"]
 pub_sub_cidr = ["192.168.0.0/24","192.168.1.0/24"]
 pri_sub_cidr = ["192.168.2.0/24","192.168.3.0/24","192.168.4.0/24","192.168.5.0/24","192.168.6.0/24","192.168.7.0/24"]
}


