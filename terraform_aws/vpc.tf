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
}

resource "aws_security_group" "dbServerSG" {
 name = "dbServerSG"
 description = "Allow RDS MySQL port(3306) from webServerSG"
 vpc_id = "${aws_vpc.spoonVPC.id}"
 ingress {
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  security_groups = ["${aws_security_group.webServerSG.id}"]
 }
}

# Internet Gateway & Routing Table
# Internet Gateway
resource "aws_internet_gateway" "spoonIGW" {
  vpc_id = "${aws_vpc.spoonVPC.id}"

  tags = {
    Name = "spoonIGW"
  }
}

# spoonPub Routing Table
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


# spoonPriA Routing Table
resource "aws_route_table" "spoonPriA" {
  vpc_id = "${aws_vpc.spoonVPC.id}"


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

# spoonPriC Routing Table
resource "aws_route_table" "spoonPriC" {
  vpc_id = "${aws_vpc.spoonVPC.id}"


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
