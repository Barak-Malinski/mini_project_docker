IMAGE ansible-master  ansible-master:v0.1
IMAGE ansible-slave   ansible-app-slave:v0.1
container name: ansible-master
container name: ansible-slave

run exec: docker exec -it ansible-master bash
run exec: docker exec -it ansible-slave bash

service ssh restart -- if sshd not runing from service ssh status
service ssh status - check if sshd is running 

docker cp ansible-slave:/root/.ssh/id_rsa .  - download key from server to host
COPY ansible-slave:/root/.ssh/id_rsa . 

docker cp id_rsa ansible-master:/
chmod 600 id_rsa - permission for linux connection

view file cat /root/.ssh/authorized_keys

ssh-keygen -R '[localhost]:2222' - rm host if I cant login to ssh

connect to ansible user
docker exec -it -u ansible ansible-slave sh

ssh -i id_rsa -p 2222 ansible@localhost

ssh -i id_rsa -p 22 ansible@172.25.0.3

Need to connect this server with dns 
ssh -i id_rsa -p 22 ansible@ansible-slave
ansible -i inventory.ini slaves -m ping

./automation.sh 

IP - ansible-master: 172.25.0.2
IP - ansible-slave: 172.25.0.3 

connect to ansible-master: docker exec -it ansible-master bash
connect to ansible-slave: docker exec -it ansible-slave bash

my volume: miniprojectdocker_myssh

source for assist:
https://stackoverflow.com/questions/27504187/ssh-key-generation-using-dockerfile

https://www.digitalocean.com/community/tutorials/how-to-use-ansible-to-install-and-set-up-docker-on-ubuntu-22-04

need to install for 2 contatiners with docker deamon shared:
docker 

into the container Server App Slave:
1. need to install docker with docker and docker compose with docker deamon
2. install python app container into container 


into the container Server DB Slave:
1. need to install docker with docker and docker compose with docker deamon
2. install postgresql app container into container - so install image with docker compose like this:
services:

install postgres for ansible-slave-2
  db:
    image: postgres
    restart: always
    # set shared memory limit when using docker compose
    # shm_size: 128mb
    # or set shared memory limit when deploy via swarm stack
    volumes:
      - type: tmpfs
        target: /dev/shm
        tmpfs:
          size: 134217728 # 128*2^20 bytes = 128Mb
    environment:
      POSTGRES_PASSWORD: mysecretpassword
    ports:
    - 8080:8080

3. pgadmin

docker deamon - volume from docker hub to server

