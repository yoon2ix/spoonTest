resource "aws_key_pair" "webServerKey" {
 key_name = "webServerKey"
 public_key = file("~/.ssh/webServerKey.pub")
}

resource "aws_instance" "bestionHost" {
 ami = "ami-01288945bd24ed49a"
 instance_type = "t2.micro"
 subnet_id = "${module.aws-network-configs.spoonPubA-id}"
 vpc_security_group_ids = [
  "${module.aws-network-configs.pubSG-id}"
 ]
 key_name = "${aws_key_pair.webServerKey}"
 count = 1
 tags {
  Name = "bestionHost"
 }
 associate_public_ip_address = true
}
