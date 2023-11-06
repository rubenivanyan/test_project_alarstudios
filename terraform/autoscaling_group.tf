#Create Launch config for webapp
resource "aws_launch_configuration" "webapp" {
  name_prefix                 = "lc2"
  image_id                    = data.aws_ami.webapp.id
  instance_type               = "t2.micro"
  key_name                    = var.mykey
  security_groups             = [aws_security_group.web_sg.id]
  associate_public_ip_address = false
  lifecycle {
    create_before_destroy = true
  }
  user_data = file(var.scriptpath)
}
#Create ASG for webapp
resource "aws_autoscaling_group" "webapp" {
  name                      = "webapp"
  min_size                  = 2
  max_size                  = 5
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.webapp.name
  vpc_zone_identifier       = [module.vpc.private_subnets[0]]
  tags = (
    [
      {
        "key"                 = "Name"
        "value"               = "flask_aws_storage"
        "propagate_at_launch" = true
      }
    ]
  )
}