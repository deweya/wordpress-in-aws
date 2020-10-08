resource "aws_security_group" "db" {
    vpc_id = aws_vpc.this.id
}

resource "aws_security_group_rule" "db_tcp" {
    type = "ingress"
    security_group_id = aws_security_group.db.id
    protocol = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
    from_port = 3306
    to_port = 3306
}

resource "aws_security_group" "wordpress" {
    vpc_id = aws_vpc.this.id
}

resource "aws_security_group_rule" "wordpress_ingress_tcp" {
    type = "ingress"
    security_group_id = aws_security_group.wordpress.id
    protocol = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
    from_port = 80
    to_port = 80
}

resource "aws_security_group_rule" "wordpress_ingress_ssh" {
    type = "ingress"
    security_group_id = aws_security_group.wordpress.id
    protocol = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
    from_port = 22
    to_port = 22
}

resource "aws_security_group_rule" "wordpress_egress_tcp" {
    type = "egress"
    security_group_id = aws_security_group.wordpress.id
    protocol = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
    from_port = 0
    to_port = 65535
}