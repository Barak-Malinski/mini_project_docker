#!/bin/bash

cd ansible-master
docker build -t ansible-master:v0.1 . 
cd ..
pwd
cd "ansible-slave-1"
docker build -t ansible-app-slave:v0.1 . 
cd ..
pwd
docker compose up -d
pwd
cd "ansible-slave-1"
docker cp ansible-slave:/home/ansible/.ssh/id_rsa .