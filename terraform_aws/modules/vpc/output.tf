# VPC ID
output "spoonVPC" {
 value = "${aws_vpc.spoonVPC.id}"
}

# Subnet ID
# Pub Subnet
output "spoonPubA-id" {
 value = "${aws_subnet.spoonPubA.id}"
}
output "spoonPubC-id" {
 value = "${aws_subnet.spoonPubC.id}"
}

# Subnet ID
# WEB Subnet
output "spoonWebA-id" {
 value = "${aws_subnet.spoonWebA.id}"
}
output "spoonWebC-id" {
 value = "${aws_subnet.spoonWebC.id}"
}

# Subnet ID
# WAS Subnet
output "spoonWasA-id" {
 value = "${aws_subnet.spoonWasA.id}"
}
output "spoonWasC-id" {
 value = "${aws_subnet.spoonWasC.id}"
}

# Subnet ID
# DB Subnet
output "spoonDBA-id" {
 value = "${aws_subnet.spoonDBA.id}"
}
output "spoonDBC-id" {
 value = "${aws_subnet.spoonDBC.id}"
}

####################################
# SG id
# Public Subnet
output "pubSG-id" {
 value = "${aws_security_group.pubSG.id}"
}

# SG id
# WEB
output "webServerSG-id" {
 value = "${aws_security_group.webServerSG.id}"
}

# SG id
# WAS
output "wasServerSG-id" {
 value = "${aws_security_group.wasServerSG.id}"
}

# SG id
# DB
output "dbServerSG-id" {
 value = "${aws_security_group.dbServerSG.id}"
}

