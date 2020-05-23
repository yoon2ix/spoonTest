variable "pubSG_id" {
 description = "Public Security Group ID"
 type = "string"
}

variable "vpc_id" {
 description = "VPC ID"
 type = "string"
}

variable "spoonPubA_id" {
 description = "AZ a, Public Subnet ID"
 type = "string"
}

variable "spoonPubC_id" {
 description = "AZ c, Public Subnet ID"
 type = "string"
}

variable "spoonWasA_id" {
 description = "AZ a, WAS Server Subnet ID"
 type = "string"
}

variable "spoonWasC_id" {
 description = "AZ c, WAS Server Subnet ID"
 type = "string"
}

variable "spoonWebA_id" {
 description = "AZ a, WEB Server Subnet ID"
 type = "string"
}

variable "spoonWebC_id" {
 description = "AZ c, WEB Server Subnet ID"
 type = "string"
}

variable "spoonDBA_id" {
 description = "AZ a, DB Server Subnet ID"
 type = "string"
}

variable "spoonDBC_id" {
 description = "AZ c, DB Server Subnet iD"
 type = "string"
}

variable "wasServerSG_id" {
 description = "Security Group for WAS Server"
 type = "string"
}

variable "webServerSG_id" {
 description = "Security Group for WEB Server"
 type = "string"
}

variable "dbServerSG_id" {
 description = "Security Group for DB Server"
 type = "string"
}

variable "avail_zones" {
 description = "AZ"
 type = "list"
}
