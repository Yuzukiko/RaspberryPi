#!/bin/sh

#Script install essential tools on system 
#Works with https://downloads.raspberrypi.org/raspios_arm64/images/
#Run with sudo 

#apt update & upgrade
sudo apt update
sudo apt upgrade

#docker
sudo curl -L "https://get.docker.com/" -o ./docker.sh
sudo bash ./docker.sh
sudo usermod -a -G docker pi

#docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.1.1/docker-compose-linux-aarch64" -o /usr/local/bin/docker-compose

#kubernetes (microk8s) 
#sudo apt install snapd
#sudo snap install microk8s --classic
#sudo usermod -a -G microk8s pi
#echo "alias kubectl='microk8s.kubectl'" >> ~/.bashrc
#cd $HOME
#mkdir .kube
#cd .kube
#microk8s config > config

#kubernetes (k3s)
sudo curl -sfL "https://get.k3s.io" | sh -

#reboot
sudo reboot

