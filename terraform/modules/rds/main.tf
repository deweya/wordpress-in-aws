resource "aws_db_subnet_group" "this" {
  name       = "wordpress"
  subnet_ids = var.private_subnet_ids
}

resource "aws_db_instance" "this" {
  allocated_storage       = 5
  storage_type            = "gp2"
  engine                  = "mariadb"
  engine_version          = "10.4"
  instance_class          = "db.t3.micro"
  name                    = var.db_name
  username                = var.db_username
  password                = var.db_password
  availability_zone       = var.availability_zones[0]
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [var.db_security_group_id]
  skip_final_snapshot     = true
  multi_az                = true
  apply_immediately       = true
  backup_window           = "05:00-05:30"
  backup_retention_period = 7

  tags = var.common_tags
}