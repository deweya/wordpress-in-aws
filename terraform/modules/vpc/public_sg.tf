resource "aws_security_group" "lb" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.common_tags,
    {
      "component" = "alb"
    }
  )
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
  count = var.deploy_bastion ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = merge(
    var.common_tags,
    {
      "component" = "bastion"
    }
  )
}

resource "aws_security_group_rule" "bastion_ingress" {
  count = var.deploy_bastion ? 1 : 0

  type              = "ingress"
  security_group_id = aws_security_group.bastion[count.index].id
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  to_port           = 22
}

resource "aws_security_group_rule" "bastion_egress" {
  count = var.deploy_bastion ? 1 : 0

  type              = "egress"
  security_group_id = aws_security_group.bastion[count.index].id
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.this.cidr_block]
  from_port         = 22
  to_port           = 22
}