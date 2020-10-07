output "private_subnet_ids" {
    value = aws_subnet.private.*.id
    description = "The private subnet IDs"
}

output "public_subnet_ids" {
    value = aws_subnet.public.*.id
    description = "The public subnet IDs"
}

output "vpc_id" {
    value = aws_vpc.this.id
    description = "The VPC ID"
}

output "db_security_group_id" {
    value = aws_security_group.private.id
    description = "The security group that the database will use"
}