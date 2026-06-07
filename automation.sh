#!/bin/bash

pwd
cd ansible-master
docker build -t ansible-master:v0.1 . 
cd ..
pwd
cd ansible-slave-1
docker build -t ansible-slave:v0.1 . 
cd ..
pwd
cd ansible
docker compose up -d
docker exec ansible-slave-app chgrp docker //var/run/docker.sock
docker exec ansible-slave-app chmod 660 //var/run/docker.sock
docker exec ansible-slave-db chgrp docker //var/run/docker.sock
docker exec ansible-slave-db chmod 660 //var/run/docker.sock
cd ..
pwd
cd slave-app-key
docker cp ansible-slave-app:/home/ansible/.ssh/id_rsa .
cd ..
pwd
cd slave-db-key
docker cp ansible-slave-db:/home/ansible/.ssh/id_rsa .
cd ..
pwd
docker exec -it ansible-master bash -c "mkdir -p /app/slave-app-key /app/slave-db-key"
docker cp slave-app-key/id_rsa ansible-master:/app/slave-app-key/id_rsa
docker cp slave-db-key/id_rsa ansible-master:/app/slave-db-key/id_rsa
docker cp ansible/deploy.yml ansible-master:/app/deploy.yml
docker exec -it ansible-slave-app bash -c "mkdir -p src"
docker cp database/docker-compose.yml ansible-slave-db:/app/docker-compose.yml
docker cp app/src/app.py ansible-slave-app:/app/src/app.py
docker cp app/docker-compose.yml ansible-slave-app:/app/docker-compose.yml
docker cp app/requirements.txt ansible-slave-app:/app/requirements.txt
docker exec -it ansible-master bash -c "chmod 600 /app/slave-app-key/id_rsa"
docker exec -it ansible-master bash -c "chmod 600 /app/slave-db-key/id_rsa"
docker exec -it ansible-master bash -c "ls -la /app/slave-app-key/id_rsa"
docker exec -it ansible-master bash -c "ls -la /app/slave-db-key/id_rsa"
docker exec -it ansible-master bash -c "mkdir -p ~/.ssh"
docker exec -it ansible-master bash -c "ssh-keyscan ansible-slave-app >> ~/.ssh/known_hosts"
docker exec -it ansible-master bash -c "mkdir -p ~/.ssh"
docker exec -it ansible-master bash -c "ssh-keyscan ansible-slave-db >> ~/.ssh/known_hosts"
cd ..
pwd
#cd ansible-slave-2
#docker compose up -d