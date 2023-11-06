#Run ansible
resource "null_resource" "ansible" {
  provisioner "local-exec" {
    command = "cd ../ansible/ && ansible-playbook -i ../ansible/aws_ec2.yaml ../ansible/playbook.yaml --vault-password-file ../../n.txt"

  }
  depends_on = [aws_instance.webapp]
}