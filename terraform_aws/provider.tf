provider "aws" {
}

terraform {
 required_version = "0.12.2"

 required_providers {
  aws = ">= 2.62.0"
 }
}

module "ec2" {
 source = "./modules/ec2"

 vpc_id = "${module.vpc.spoonVPC}"
 
 pubSG_id = "${module.vpc.pubSG-id}"
 spoonPubA_id = "${module.vpc.spoonPubA-id}"
 spoonPubC_id="${module.vpc.spoonPubC-id}"
 spoonWasA_id="${module.vpc.spoonWasA-id}"
 spoonWasC_id="${module.vpc.spoonWasC-id}"
 spoonWebA_id="${module.vpc.spoonWebA-id}"
 spoonWebC_id="${module.vpc.spoonWebC-id}"
 spoonDBA_id="${module.vpc.spoonDBA-id}"
 spoonDBC_id="${module.vpc.spoonDBC-id}"
 wasServerSG_id="${module.vpc.wasServerSG-id}"
 webServerSG_id="${module.vpc.webServerSG-id}"
 dbServerSG_id="${module.vpc.dbServerSG-id}"

}

module "vpc" {
 source = "./modules/vpc"

 name = "spoonVPC"
 vpc_cidr = "192.168.0.0/16"

 avail_zones = ["ap-northeast-2a", "ap-northeast-2c"]
 pub_sub_cidr = ["192.168.0.0/24","192.168.1.0/24"]
 pri_sub_cidr = ["192.168.2.0/24","192.168.3.0/24","192.168.4.0/24","192.168.5.0/24","192.168.6.0/24","192.168.7.0/24"]
}


