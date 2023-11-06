#Create development server
resource "aws_instance" "webapp" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  key_name      = var.mykey
  subnet_id     = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.main_sg.id]
  tags = {
    Name  = "webapp"
  }
}