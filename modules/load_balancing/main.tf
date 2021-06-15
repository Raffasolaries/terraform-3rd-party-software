/* Network Load Balncer */
resource "aws_lb" "nlb" {
 name               = "${var.environment}-nlb"
 internal           = false
 load_balancer_type = "network"
 subnets            = var.public_subnet_ids

 enable_deletion_protection = true

 tags = {
  Name = "${var.environment}-nlb"
  Environment = var.environment
 }
}
/* Target group */
resource "aws_lb_target_group" "instance" {
 name        = "${var.environment}-${var.app_name}-tg"
 port        = 80
 protocol    = "HTTP"
 target_type = "instance"
 vpc_id      = var.vpc_id

 health_check {
  matcher = "200-299"
  path = "/"
 }

 stickiness {
  enabled = true
  type = "source_ip"
 }

 tags = {
  Name = "${var.environment}-${var.app_name}-tg"
  Environment = var.environment
 }
}
/* Target group attachment */
resource "aws_lb_target_group_attachment" "instance_attachment" {
 target_group_arn = aws_lb_target_group.instance.arn
 target_id        = var.instance_id
}
// /* Main listener */
// resource "aws_lb_listener" "https" {
//  load_balancer_arn = aws_lb.nlb.arn
//  port              = "80"
//  protocol          = "TCP"

//  default_action {
//    type             = "forward"
//    target_group_arn = aws_lb_target_group.instance.arn
//  }
// }

/* Redirects all HTTP traffic to HTTPS */
resource "aws_lb_listener" "http" {
 load_balancer_arn = aws_lb.nlb.arn
 port              = "80"
 protocol          = "HTTP"

 default_action {
  type = "redirect"

  redirect {
    port        = "443"
    protocol    = "HTTPS"
    status_code = "HTTP_301"
  }
 }
}
/* HTTPS listener rule */
resource "aws_lb_listener" "https" {
 load_balancer_arn = aws_lb.nlb.arn
 port              = "443"
 protocol          = "TLS"
 certificate_arn   = var.certificate_arn

 default_action {
   type             = "forward"
   target_group_arn = aws_lb_target_group.instance.arn
 }
}