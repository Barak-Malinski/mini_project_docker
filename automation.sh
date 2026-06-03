#!/bin/bash

pwd
cd ansible-master
docker build -t ansible-master:v0.1 . 
cd ..
pwd
cd ansible-slave-1
docker build -t ansible-app-slave:v0.1 . 
cd ..
pwd
cd ansible
docker compose up -d
cd ..
pwd
cd ansible-slave-1
docker cp ansible-slave:/home/ansible/.ssh/id_rsa .
docker cp id_rsa ansible-master:/app/id_rsa
docker exec -it ansible-master bash -c "chmod 600 /app/id_rsa"
docker exec -it ansible-master bash -c "ls -la /app/id_rsa"
docker exec -it ansible-master bash -c "mkdir -p ~/.ssh"
docker exec -it ansible-master bash -c "ssh-keyscan ansible-slave >> ~/.ssh/known_hosts"
cd ..
pwd
cd ansible-slave-2
docker compose up -d