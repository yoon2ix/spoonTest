resource "aws_vpc" "spoonVPC" {
 cidr_block = "${var.vpc_cidr}"
 tags = {
  Name = "${var.name}"
 }
 enable_dns_hostnames = "true"
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

resource "aws_security_group" "pubSG" {
 name = "pubSG"
 vpc_id = "${aws_vpc.spoonVPC.id}"
 ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
  from_port = -1
  to_port = -1
  protocol = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
 }

 egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_security_group" "webServerSG" {
 name = "webServerSG"
 description = "Allow WEB, WAS port(80) and SSH port(22) from all"
 vpc_id = "${aws_vpc.spoonVPC.id}"
 ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
  from_port = -1
  to_port = -1
  protocol = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_security_group" "wasServerSG" {
 name = "wasServerSG"
 description = "Allow HTTP port(80) and SSH port(22) from webServerSG"
 vpc_id = "${aws_vpc.spoonVPC.id}"
 ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_groups = ["${aws_security_group.webServerSG.id}"]
 }
 ingress {
  from_port = -1
  to_port = -1
  protocol = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_security_group" "dbServerSG" {
 name = "dbServerSG"
 description = "Allow RDS MySQL port(3306) from wasServerSG"
 vpc_id = "${aws_vpc.spoonVPC.id}"
 ingress {
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  security_groups = ["${aws_security_group.wasServerSG.id}"]
 }
 egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_internet_gateway" "spoonIGW" {
  vpc_id = "${aws_vpc.spoonVPC.id}"

  tags = {
    Name = "spoonIGW"
  }
}


resource "aws_route_table" "spoonPub" {
  vpc_id = "${aws_vpc.spoonVPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.spoonIGW.id}"
  }

  tags = {
    Name = "spoonPub"
  }
}

resource "aws_route_table_association" "spoonPubAAssoc" {
  subnet_id      = aws_subnet.spoonPubA.id
  route_table_id = aws_route_table.spoonPub.id
}
resource "aws_route_table_association" "spoonPubCAssoc" {
  subnet_id      = aws_subnet.spoonPubC.id
  route_table_id = aws_route_table.spoonPub.id
}

resource "aws_route_table" "spoonPriA" {
  vpc_id = "${aws_vpc.spoonVPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.pubA-NAT.id}"
  }

  tags = {
    Name = "spoonPriA"
  } 
}

resource "aws_route_table_association" "spoonPriAWebAssoc" {
  subnet_id      = aws_subnet.spoonWebA.id
  route_table_id = aws_route_table.spoonPriA.id
}
resource "aws_route_table_association" "spoonPriAWasAssoc" {
  subnet_id      = aws_subnet.spoonWasA.id
  route_table_id = aws_route_table.spoonPriA.id
}
resource "aws_route_table_association" "spoonPriADBAssoc" {
  subnet_id      = aws_subnet.spoonDBA.id
  route_table_id = aws_route_table.spoonPriA.id
}


resource "aws_route_table" "spoonPriC" {
  vpc_id = "${aws_vpc.spoonVPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.pubC-NAT.id}"
  }

  tags = {
    Name = "spoonPriC"
  } 
}

resource "aws_route_table_association" "spoonPriCWebAssoc" {
  subnet_id      = aws_subnet.spoonWebC.id
  route_table_id = aws_route_table.spoonPriC.id
}
resource "aws_route_table_association" "spoonPriCWasAssoc" {
  subnet_id      = aws_subnet.spoonWasC.id
  route_table_id = aws_route_table.spoonPriC.id
}
resource "aws_route_table_association" "spoonPriCDBAssoc" {
  subnet_id      = aws_subnet.spoonDBC.id
  route_table_id = aws_route_table.spoonPriC.id
}

# EIP for NAT Gateway
resource "aws_eip" "pubA-EIP" {
 vpc = true
}

resource "aws_eip" "pubC-EIP" {
 vpc = true
}

# NAT Gateway
resource "aws_nat_gateway" "pubA-NAT"{
 allocation_id = "${aws_eip.pubA-EIP.id}"
 subnet_id = "${aws_subnet.spoonPubA.id}"
}

resource "aws_nat_gateway" "pubC-NAT"{
 allocation_id = "${aws_eip.pubC-EIP.id}"
 subnet_id = "${aws_subnet.spoonPubC.id}"
}
