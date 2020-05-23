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

 tags = {
  Name = "webServer"
 }
}

# Was Server
resource "aws_instance" "wasServer" {

 ami = "ami-01288945bd24ed49a"
 instance_type = "t2.micro"
 subnet_id = "${var.spoonWasA_id}"
 vpc_security_group_ids = [
  "${var.wasServerSG_id}"
 ]
 key_name = "${aws_key_pair.webServerKey.key_name}"

 tags = {
  Name = "wasServer"
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
  internal           = true
  load_balancer_type = "application"
  security_groups    = ["${var.wasServerSG_id}"]
  subnets            = ["${var.spoonWasA_id}","${var.spoonWasC_id}"]

}

# Target Group
resource "aws_lb_target_group" "webALB_tagetGroup" {
  name     = "webALB-tagetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_lb_target_group" "wasALB_tagetGroup" {
  name     = "wasALB-tagetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}

# Application Load Balancer Listener
resource "aws_lb_listener" "webALB_listener" {
  load_balancer_arn = "${aws_lb.webALB.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.webALB_tagetGroup.arn}"
  }
}

resource "aws_lb_listener" "wasALB_listener" {
  load_balancer_arn = "${aws_lb.wasALB.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.wasALB_tagetGroup.arn}"
  }
}

# Create AMI from instance
resource "aws_ami_from_instance" "webTemplate" {
 name = "webTemplate"
 source_instance_id = "${aws_instance.webServer.id}"
}

resource "aws_ami_from_instance" "wasTemplate" {
 name = "wasTemplate"
 source_instance_id = "${aws_instance.wasServer.id}"
}

# Auto Scaling Group 
# Launch Template

resource "aws_launch_template" "webAutoScalingTemplate" {
 name_prefix = "webAutoScalingTemplate"
 image_id = "${aws_ami_from_instance.webTemplate.id}"
 instance_type = "t2.micro"
 vpc_security_group_ids = ["${var.webServerSG_id}"]

 key_name = "${aws_key_pair.webServerKey.key_name}"

}

resource "aws_launch_template" "wasAutoScalingTemplate" {
 name_prefix = "wasAutoScalingTemplate"
 image_id = "${aws_ami_from_instance.wasTemplate.id}"
 instance_type = "t2.micro"
 vpc_security_group_ids = ["${var.wasServerSG_id}"]

 key_name = "${aws_key_pair.webServerKey.key_name}"

}


# Autoscaling Group
resource "aws_autoscaling_group" "webAutoScalingGroup" {
 name = "webAutoScalingGroup"
 availability_zones = ["${var.avail_zones[0]}","${var.avail_zones[1]}"]
 desired_capacity = 2
 min_size = 2
 max_size = 4 
 vpc_zone_identifier = ["${var.spoonWebA_id}","${var.spoonWebC_id}"]

 launch_template {
   id      = "${aws_launch_template.webAutoScalingTemplate.id}"
   version = "$Latest"
 }
}


resource "aws_autoscaling_group" "wasAutoScalingGroup" {
 name = "wasAutoScalingGroup"
 availability_zones = ["${var.avail_zones[0]}","${var.avail_zones[1]}"]
 desired_capacity = 2
 min_size = 2
 max_size = 4
 vpc_zone_identifier = ["${var.spoonWasA_id}","${var.spoonWasC_id}"]

 launch_template {
   id      = "${aws_launch_template.wasAutoScalingTemplate.id}"
   version = "$Latest"
 }
}

# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "webServer_attachment" {
 autoscaling_group_name = "${aws_autoscaling_group.webAutoScalingGroup.id}"

 alb_target_group_arn   = "${aws_lb_target_group.webALB_tagetGroup.arn}"
}


# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "wasServer_attachment" {
 autoscaling_group_name = "${aws_autoscaling_group.wasAutoScalingGroup.id}"

 alb_target_group_arn   = "${aws_lb_target_group.wasALB_tagetGroup.arn}"
}

