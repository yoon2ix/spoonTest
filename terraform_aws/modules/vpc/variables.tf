variable "name" {
 description = "VPC Name"
 type = "string"
}

variable "vpc_cidr" {
 description = "VPC CIDR Block"
 type = "string"
}

variable "avail_zones" {
 description = "Availabliliry Zones"
 type = "list"
}

variable "pub_sub_cidr" {
 description = "Public Subnet CIDR Block list"
 type = "list"
}

variable "pri_sub_cidr" {
 description = "Private Subnet CIDR Block list"
 type = "list"
}
