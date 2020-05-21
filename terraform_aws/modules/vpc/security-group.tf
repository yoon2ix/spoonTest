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

resource "aws_security_group" "wasServerSG" {
 name = "wasServerSG"
 description = "Allow HTTP port(80) and SSH port(22) from webServerSG"
 vpc_id = "${aws_vpc.spoonVPC.id}"
 ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  security_groups = ["${aws_security_group.webServerSG.id}"]
 }
 ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_groups = ["${aws_security_group.webServerSG.id}"]
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
}
