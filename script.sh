#! /bin/bash
cd /home/ubuntu/flask_aws_storage/
echo "cddir" > b.txt
ip4=$(hostname -I)
echo "$ip4" > y.txt
flask run --host=$ip4 --port=8080