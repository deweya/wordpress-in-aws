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

    user_data = <<EOF
#!/bin/bash
rm -f /var/www/html/.htaccess
echo "SetEnv DB_NAME ${var.db_name}" >> /var/www/html/.htaccess
echo "SetEnv DB_USER ${var.db_username}" >> /var/www/html/.htaccess
echo "SetEnv DB_PASSWORD ${var.db_password}" >> /var/www/html/.htaccess
echo "SetEnv DB_HOST ${var.db_host}" >> /var/www/html/.htaccess
EOF

    network_interface {
        network_interface_id = aws_network_interface.wordpress[count.index].id
        device_index = 0
    }
}

resource "aws_instance" "bastion" {
    count = length(var.availability_zones)

    ami = "ami-000e7ce4dd68e7a11"
    instance_type = "t2.micro"
    key_name = "wordpress"
    associate_public_ip_address = true
    vpc_security_group_ids = [var.bastion_sg_id]
    subnet_id = var.public_subnet_ids[count.index]
}