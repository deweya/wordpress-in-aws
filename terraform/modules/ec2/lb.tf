resource "aws_lb" "this" {
    name = "wordpress-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = [var.lb_sg_id]
    subnets = var.public_subnet_ids
}

resource "aws_lb_target_group" "this" {
    name = "wordpress-lb-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id

    health_check {
        path = "/wordpress/wp-content/index.php"
        matcher = "200-299"
    }
}

resource "aws_lb_target_group_attachment" "this" {
    count = length(var.availability_zones)
    
    target_group_arn = aws_lb_target_group.this.arn
    target_id = aws_instance.wordpress[count.index].id
    port = 80
}

resource "aws_lb_listener" "this" {
    load_balancer_arn = aws_lb.this.arn
    port = 80
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.this.arn
    }
}