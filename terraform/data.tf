#Get aws_account username id
data "aws_caller_identity" "current" {}
#Dataset from webapp image
data "aws_ami" "webapp" {
  most_recent = true

  filter {
    name   = "name"
    values = ["webapp"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [data.aws_caller_identity.current.account_id] # MySelf
  depends_on = [
    aws_ami_from_instance.webapp
  ]
}