resource "aws_instance" "webserver" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = aws_route_table.tf-rtb-public[0].id
  key_name = var.key_name
  tags = merge(var.tags, {
    "Name" = "Webserver"
  }
 )
}