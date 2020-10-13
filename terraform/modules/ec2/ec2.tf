resource "aws_network_interface" "wordpress" {
  count = length(var.availability_zones)

  subnet_id       = var.deploy_wp_to_private_subnet ? var.private_subnet_ids[count.index] : var.public_subnet_ids[count.index]
  security_groups = [var.wordpress_sg]

  tags = merge(
    var.common_tags,
    {
      "component" = "wordpress"
    }
  )
}

resource "aws_instance" "wordpress" {
  count = length(var.availability_zones)

  ami           = var.wordpress_ami
  instance_type = "t2.micro"
  key_name      = var.key_pair != "" ? var.key_pair : null

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
    device_index         = 0
  }

  tags = merge(
    var.common_tags,
    {
      "component" = "wordpress"
    }
  )
}

resource "aws_instance" "bastion" {
  count = var.key_pair != "" ? length(var.availability_zones) : 0

  ami                         = "ami-000e7ce4dd68e7a11"
  instance_type               = "t2.micro"
  key_name                    = "wordpress"
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.bastion_sg_id]
  subnet_id                   = var.public_subnet_ids[count.index]

  tags = merge(
    var.common_tags,
    {
      "component" = "bastion"
    }
  )
}