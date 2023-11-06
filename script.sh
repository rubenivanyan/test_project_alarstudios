#! /bin/bash
cd /home/ubuntu/flask_aws_storage/
ip4=$(hostname -I)
flask run --host=$ip4 --port=8080