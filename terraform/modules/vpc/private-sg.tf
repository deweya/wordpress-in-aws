resource "aws_security_group" "private" {
    vpc_id = aws_vpc.this.id
}

resource "aws_security_group_rule" "private_ingress_tcp" {
    type = "ingress"
    security_group_id = aws_security_group.private.id
    protocol = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
    from_port = 3306
    to_port = 3306
}