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
