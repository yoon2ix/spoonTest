resource "aws_vpc" "spoonVPC" {
 cidr_block = "192.168.0.0/16"
 tags = {
  Name = "spoonVPC"
 }
}

resource "aws_subnet" "spoonPubA" {
 vpc_id = "${aws_vpc.spoonVPC.id}"
 cidr_block = "192.168.0.0/24"

 tags = {
  Name = "spoonPubA"
 }
}

resource "aws_subnet" "spoonPubC" {
 vpc_id = "${aws_vpc.spoonVPC.id}"
 cidr_block = "192.168.1.0/24"
 availability_zone = "ap-northeast-2c"

 tags = {
  Name = "spoonPubC"
 }
}

resource "aws_subnet" "spoonWebA" {
 vpc_id = "${aws_vpc.spoonVPC.id}"
 cidr_block = "192.168.2.0/24"
 availability_zone = "ap-northeast-2a"

 tags = {
  Name = "spoonWebA"
 }
}

resource "aws_subnet" "spoonWebC" {
 vpc_id = "${aws_vpc.spoonVPC.id}"
 cidr_block = "192.168.3.0/24"
 availability_zone = "ap-northeast-2c"

 tags = {
  Name = "spoonWebC"
 }
}

resource "aws_subnet" "spoonWasA" {
 vpc_id = "${aws_vpc.spoonVPC.id}"
 cidr_block = "192.168.4.0/24"
 availability_zone = "ap-northeast-2a"

 tags = {
  Name = "spoonWasA"
 }
}

resource "aws_subnet" "spoonWasC" {
 vpc_id = "${aws_vpc.spoonVPC.id}"
 cidr_block = "192.168.5.0/24"
 availability_zone = "ap-northeast-2c"

 tags = {
  Name = "spoonWasC"
 }
}

resource "aws_subnet" "spoonDBA" {
 vpc_id = "${aws_vpc.spoonVPC.id}"
 cidr_block = "192.168.6.0/24"
 availability_zone = "ap-northeast-2a"

 tags = {
  Name = "spoonDBA"
 }
}

resource "aws_subnet" "spoonDBC" {
 vpc_id = "${aws_vpc.spoonVPC.id}"
 cidr_block = "192.168.7.0/24"
 availability_zone = "ap-northeast-2c"

 tags = {
  Name = "spoonDBC"
 }
}
