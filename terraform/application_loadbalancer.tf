#define local variables
locals {
  vpc_id2 = module.vpc.vpc_id
}
#Create application load balancer service1
resource "aws_lb" "applb" {
  name               = "applb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false

  tags = {
    Environment = "development"
  }
}
#Create target_group
resource "aws_lb_target_group" "webapp" {
  name     = "webapp"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id2
  health_check {
    path = var.health_check_path
  }
}
#Create listener
resource "aws_lb_listener" "listen8080" {
  load_balancer_arn = aws_lb.applb.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.webapp.id
    type             = "forward"
  }
}