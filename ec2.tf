resource "aws_instance" "webserver" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.tf-public-subnets[0].id
  key_name = var.key_name
  tags = merge(var.tags, {
    "Name" = "Webserver"
  }
 )
}