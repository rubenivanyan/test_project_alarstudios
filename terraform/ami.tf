#Create Image form webapp installed host
resource "aws_ami_from_instance" "webapp" {
  name               = "webapp"
  source_instance_id = aws_instance.webapp.id
  depends_on         = [null_resource.ansible]
}