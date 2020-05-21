resource "aws_vpc" "spoonVPC" {
 cidr_block = "${var.vpc_cidr}"
 tags = {
  Name = "${var.name}"
 }
}

resource "aws_subnet" "spoonPubA" {
 vpc_id = "${aws_vpc.spoonVPC.id}"
 cidr_block = "${var.pub_sub_cidr[0]}"
 availability_zone = "${var.avail_zones[0]}"

 tags = {
  Name = "spoonPubA"
 }
}

resource "aws_subnet" "spoonPubC" {
 vpc_id = "${aws_vpc.spoonVPC.id}"
 cidr_block = "${var.pub_sub_cidr[1]}"
 availability_zone = "${var.avail_zones[1]}"

 tags = {
  Name = "spoonPubC"
 }
}

resource "aws_subnet" "spoonWebA" {
 vpc_id = "${aws_vpc.spoonVPC.id}"
 cidr_block = "${var.pri_sub_cidr[0]}"
 availability_zone = "${var.avail_zones[0]}"

 tags = {
  Name = "spoonWebA"
 }
}

resource "aws_subnet" "spoonWebC" {
 vpc_id = "${aws_vpc.spoonVPC.id}"
 cidr_block = "${var.pri_sub_cidr[1]}"
 availability_zone = "${var.avail_zones[1]}"

 tags = {
  Name = "spoonWebC"
 }
}

resource "aws_subnet" "spoonWasA" {
 vpc_id = "${aws_vpc.spoonVPC.id}"
 cidr_block = "${var.pri_sub_cidr[2]}"
 availability_zone = "${var.avail_zones[0]}"

 tags = {
  Name = "spoonWasA"
 }
}

resource "aws_subnet" "spoonWasC" {
 vpc_id = "${aws_vpc.spoonVPC.id}"
 cidr_block = "${var.pri_sub_cidr[3]}"
 availability_zone = "${var.avail_zones[1]}"

 tags = {
  Name = "spoonWasC"
 }
}

resource "aws_subnet" "spoonDBA" {
 vpc_id = "${aws_vpc.spoonVPC.id}"
 cidr_block = "${var.pri_sub_cidr[4]}"
 availability_zone = "${var.avail_zones[0]}"

 tags = {
  Name = "spoonDBA"
 }
}

resource "aws_subnet" "spoonDBC" {
 vpc_id = "${aws_vpc.spoonVPC.id}"
 cidr_block = "${var.pri_sub_cidr[5]}"
 availability_zone = "${var.avail_zones[0]}"

 tags = {
  Name = "spoonDBC"
 }
}
