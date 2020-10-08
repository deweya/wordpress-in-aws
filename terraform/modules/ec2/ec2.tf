resource "aws_network_interface" "wordpress" {
    count = length(var.availability_zones)

    subnet_id = var.private_subnet_ids[count.index]
    security_groups = [var.wordpress_sg]
}

resource "aws_instance" "wordpress" {
    count = length(var.availability_zones)

    ami = var.wordpress_ami
    instance_type = "t2.micro"
    key_name = "wordpress"

    network_interface {
        network_interface_id = aws_network_interface.wordpress[count.index].id
        device_index = 0
    }
}