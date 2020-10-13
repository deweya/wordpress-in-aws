resource "aws_subnet" "public" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet("10.0.0.0/24", 3, count.index)
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    var.common_tags,
    {
      "visibility" = "public"
    }
  )
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = var.common_tags
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = var.common_tags
}

resource "aws_main_route_table_association" "main" {
  vpc_id         = aws_vpc.this.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "public" {
  count = length(var.availability_zones)

  route_table_id = aws_route_table.main.id
  subnet_id      = aws_subnet.public[count.index].id
}

resource "aws_eip" "nat" {
  count = var.deploy_wp_to_private_subnet ? length(var.availability_zones) : 0

  vpc = true

  depends_on = [aws_internet_gateway.this]

  tags = var.common_tags
}

resource "aws_nat_gateway" "this" {
  count = var.deploy_wp_to_private_subnet ? length(var.availability_zones) : 0

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = var.common_tags
}