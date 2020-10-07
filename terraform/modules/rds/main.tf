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
    username = "my-user"
    password = "my-pass"
    availability_zone = "us-east-2a"
}