resource "aws_security_group" "lb" {
  vpc_id = aws_vpc.this.id
}

resource "aws_security_group_rule" "lb_ingress" {
  type              = "ingress"
  security_group_id = aws_security_group.lb.id
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  to_port           = 80
}

resource "aws_security_group_rule" "lb_egress" {
  type              = "egress"
  security_group_id = aws_security_group.lb.id
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.this.cidr_block]
  from_port         = 80
  to_port           = 80
}

resource "aws_security_group" "bastion" {
  vpc_id = aws_vpc.this.id
}

resource "aws_security_group_rule" "bastion_ingress" {
  type              = "ingress"
  security_group_id = aws_security_group.bastion.id
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  to_port           = 22
}

resource "aws_security_group_rule" "bastion_egress" {
  type              = "egress"
  security_group_id = aws_security_group.bastion.id
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.this.cidr_block]
  from_port         = 22
  to_port           = 22
}