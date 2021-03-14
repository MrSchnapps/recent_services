#!/bin/bash -e

print_separate() {
    echo "*********************"
    echo $1
    echo
}
#image creation
build_img() {
    echo "Building $1 image."
    docker build -t "$1-img" "srcs/$1"
    echo 
}

#service creation
build_service() {
    echo "Creating $1 service."
    kubectl apply -f "srcs/$1/srcs/$1.yaml"
    echo
}

print_separate "Starting Minikube"
minikube delete
minikube start --driver=virtualbox
#minikube --vm-driver=docker start #--extra-config=apiserver.service-node-port-range=1-35000
#minikube start --driver=none

print_separate "Setting Dashboard"
minikube addons enable dashboard
minikube dashboard &

eval $(minikube docker-env)

print_separate "Setting MetalLb"
minikube addons enable metallb
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e 's/strictARP: false/strictARP: true/' -e 's/mode: ""/mode: "ipvs"/' | \
kubectl apply -f - -n kube-system
#Installation by manifest
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml

kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/metallb-config.yaml

print_separate

build_img nginx
build_img wordpress
build_img phpmyadmin
build_img grafana
build_img ftps
build_img influxdb

build_service nginx
build_service wordpress
build_service phpmyadmin
build_service grafana
build_service ftps
build_service influxdb