resource "aws_network_interface" "wordpress" {
  count = var.deploy_wp_to_private_subnet ? length(var.availability_zones): 0

  subnet_id       = var.deploy_wp_to_private_subnet ? var.private_subnet_ids[count.index] : var.public_subnet_ids[count.index]
  security_groups = [var.wordpress_sg]

  tags = merge(
    var.common_tags,
    {
      "component" = "wordpress"
    }
  )
}

resource "aws_network_interface_attachment" "wordpress" {
  count = var.deploy_wp_to_private_subnet ? length(var.availability_zones): 0

  instance_id = aws_instance.wordpress[count.index].id
  network_interface_id = aws_network_interface.wordpress[count.index].id
  device_index = 0
}

resource "aws_instance" "wordpress" {
  count = length(var.availability_zones)

  ami           = var.wordpress_ami
  instance_type = "t2.micro"
  key_name      = var.key_pair != "" ? var.key_pair : null
  associate_public_ip_address = var.deploy_wp_to_private_subnet ? false : true
  subnet_id = var.deploy_wp_to_private_subnet ? null : var.public_subnet_ids[count.index]
  security_groups = var.deploy_wp_to_private_subnet ? null : [var.wordpress_sg]
  iam_instance_profile = var.instance_profile_name

  user_data = <<EOF
#!/bin/bash
rm -f /var/www/html/.htaccess
echo "SetEnv DB_NAME $(aws ssm get-parameters --names db_name | jq -r '.Parameters[0].Value')" >> /var/www/html/.htaccess
echo "SetEnv DB_USER $(aws ssm get-parameters --names db_username | jq -r '.Parameters[0].Value')" >> /var/www/html/.htaccess
echo "SetEnv DB_PASSWORD $(aws ssm get-parameters --names db_password | jq -r '.Parameters[0].Value')" >> /var/www/html/.htaccess
echo "SetEnv DB_HOST ${var.db_host}" >> /var/www/html/.htaccess
EOF

  tags = merge(
    var.common_tags,
    {
      "component" = "wordpress"
    }
  )
}

resource "aws_instance" "bastion" {
  count = var.deploy_bastion ? length(var.availability_zones) : 0

  ami                         = "ami-000e7ce4dd68e7a11"
  instance_type               = "t2.micro"
  key_name                    = "wordpress"
  associate_public_ip_address = true
  vpc_security_group_ids      = var.deploy_bastion ? [var.bastion_sg_id] : null
  subnet_id                   = var.public_subnet_ids[count.index]

  tags = merge(
    var.common_tags,
    {
      "component" = "bastion"
    }
  )
}