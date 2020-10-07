output "private_subnet_ids" {
    value = aws_subnet.private.*.id
    description = "The private subnet IDs"
}