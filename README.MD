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

view file cat /root/.ssh/authorized_keys

ssh-keygen -R '[localhost]:2222' - rm host if I cant login to ssh

connect to ansible user
docker exec -it -u ansible ansible-slave sh

ssh -i id_rsa -p 2222 ansible@localhost

chmod 600 id_rsa - permission for linux connection

./automation.sh 

cp -r "/mnt/c/Users/barak/OneDrive/Desktop/Mini Project docker" /home/barak/ - copy from host to linux folder 

IP - ansible-master: 172.23.0.2
IP - ansible-slave: 172.23.0.3

connect to ansible-master: docker exec -it ansible-master bash
connect to ansible-slave: docker exec -it ansible-slave bash


source for assist:
https://stackoverflow.com/questions/27504187/ssh-key-generation-using-dockerfile

https://www.digitalocean.com/community/tutorials/how-to-use-ansible-to-install-and-set-up-docker-on-ubuntu-22-04