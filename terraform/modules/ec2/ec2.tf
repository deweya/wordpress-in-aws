resource "aws_instance" "wordpress" {
    count = 1

    ami = var.wordpress_ami
    instance_type = "t2.micro"
    associate_public_ip_address = true
    vpc_security_group_ids = ["sg-05030c6159c229e74"]
    subnet_id = "subnet-0fa6473b784da7778"
    key_name = "wordpress"
}