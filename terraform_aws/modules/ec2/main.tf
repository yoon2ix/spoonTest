resource "aws_key_pair" "webServerKey" {
 key_name = "webServerKey"
 public_key = file("~/.ssh/webServerKey.pub")
}

resource "aws_instance" "bestionHost" {

 ami = "ami-01288945bd24ed49a"
 instance_type = "t2.micro"
 subnet_id = "${var.spoonPubA_id}"
 vpc_security_group_ids = [
  "${var.pubSG_id}"
 ]
 key_name = "${aws_key_pair.webServerKey.key_name}"
 count = 1
 associate_public_ip_address = true

 tags = {
  Name = "bestionHost"
 }
}
