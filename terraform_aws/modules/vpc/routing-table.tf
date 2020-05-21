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
