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

# nginx Server
resource "aws_instance" "webServer" {

 ami = "ami-01288945bd24ed49a"
 instance_type = "t2.micro"
 subnet_id = "${var.spoonWebA_id}"
 vpc_security_group_ids = [
  "${var.webServerSG_id}"
 ]
 key_name = "${aws_key_pair.webServerKey.key_name}"
 count = 1

 tags = {
  Name = "webServer"
 }
}


# Create ALB

resource "aws_lb" "webALB" {
  name               = "webALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.webServerSG_id}"]
  subnets            = ["${var.spoonWebA_id}","${var.spoonWebC_id}"]


}

resource "aws_lb" "wasALB" {
  name               = "wasALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.wasServerSG_id}"]
  subnets            = ["${var.spoonWasA_id}","${var.spoonWasC_id}"]

}
