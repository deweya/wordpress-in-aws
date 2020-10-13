output "private_subnet_ids" {
  value       = aws_subnet.private.*.id
  description = "The private subnet IDs"
}

output "public_subnet_ids" {
  value       = aws_subnet.public.*.id
  description = "The public subnet IDs"
}

output "vpc_id" {
  value       = aws_vpc.this.id
  description = "The VPC ID"
}

output "db_security_group_id" {
  value       = aws_security_group.db.id
  description = "The security group that the RDS database will use"
}

output "wordpress_sg" {
  value       = aws_security_group.wordpress.id
  description = "The security group that wordpress ec2 instances will use"
}

output "lb_sg_id" {
  value       = aws_security_group.lb.id
  description = "The security group that the ALB will use"
}

output "bastion_sg_id" {
  value       = var.deploy_bastion ? aws_security_group.bastion[0].id : null
  description = "The security group that the basion will use"
}