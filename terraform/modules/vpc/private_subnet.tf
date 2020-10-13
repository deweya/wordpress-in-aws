resource "aws_subnet" "private" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet("10.0.0.0/24", 3, count.index + length(var.availability_zones))
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    var.common_tags,
    {
      "visibility" = "private"
    }
  )
}

resource "aws_route_table" "private" {
  count = var.deploy_wp_to_private_subnet ? length(var.availability_zones) : 0

  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this[count.index].id
  }

  tags = merge(
    var.common_tags,
    {
      "visibility" = "private"
    }
  )
}

resource "aws_route_table_association" "private" {
  count = var.deploy_wp_to_private_subnet ? length(var.availability_zones) : 0

  route_table_id = aws_route_table.private[count.index].id
  subnet_id      = aws_subnet.private[count.index].id
}