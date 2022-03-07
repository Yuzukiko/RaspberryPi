#!/bin/bash

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
sudo curl -L "https://github.com/docker/compose/releases/download/v2.1.1/docker-compose-linux-armv7" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

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
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo echo "cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory" > /boot/cmdline.txt
sudo reboot
sudo curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s -
sudo export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

#helm
sudo curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# rancher DOESNT WORK
#curl -sfL https://get.rancher.io | sh -

#Pihole

#Cert manager (required for Actions Runner)
#kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.6.1/cert-manager.yaml

#Actions Runner

#kubectl apply -f https://github.com/actions-runner-controller/actions-runner-controller/releases/download/v0.20.4/actions-runner-controller.yaml

#DDNS


# Flux
curl -s https://fluxcd.io/install.sh | sudo bash
kubectl create namespace flux

export GITHUB_TOKEN=<your-token>
export GITHUB_USER=<your-username>
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=<my-repository> \
  --path=clusters/production \
  --personal