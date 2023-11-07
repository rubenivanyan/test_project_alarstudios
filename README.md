# test_project_alarstudios

## Introduction
This is a small web application. Using this web application you can easily upload your files from the browser to S3 bucket in amazon. 
## Prerequisites 
1. Operating System: Ubuntu 20.04, aws account
2. Install `terraform`, `ansible`, `python3`, `botocore`, `boto3`, `openssh-server` on your Ubuntu machine

## Steps to deploy the project
1. Clone the repository into your Ubuntu machine, into directory your user (exmample: /home/user/)
2. Change parameters in ansible.cfg file for your own & move to /etc/ansible/ directory, use your own credentials for connect to your aws account & ec2 instances, change terraform variables if required
3. run command terraform init from directory terraform
4. run command terraform apply from directory terraform
5. Enjoy !! Your infrastucture will be ready approximately about 20 minutes

## Steps after infrastructure ready
1. There is also manual steps))
2. Register target in target groups in your aws account
3. Create iamuser in aws account with access to s3 bucket
4. In app servers configure iam user with awscli command aws configure

## Extras

web-application
