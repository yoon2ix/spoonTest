resource "aws_key_pair" "webServerKey" {
 key_name = "webServerKey"
 public_key = file("~/.ssh/webServerKey.pub")
}
