resource "aws_db_subnet_group" "this" {
    name = "wordpress"
    subnet_ids = var.private_subnet_ids
}

resource "aws_db_instance" "this" {
    allocated_storage = 5
    storage_type = "gp2"
    engine = "mariadb"
    engine_version = "10.4"
    instance_class = "db.t3.micro"
    name = "wordpress"
    username = "myuser123"
    password = "mypass123"
    availability_zone = "us-east-2a"
    db_subnet_group_name = aws_db_subnet_group.this.name
    vpc_security_group_ids = [var.db_security_group_id]
    skip_final_snapshot = true
}