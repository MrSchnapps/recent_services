
RED="\e[91m"
GREEN="\e[92m"
YELLOW="\e[93m"
BLUE="\e[94m"
PURPLE="\e[95m"
CYAN="\e[96m"
WHITE="\e[97m"

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

echo "Configuring minikube..."
	echo -en $BLUE
	minikube delete
	minikube start --driver=virtualbox
	#minikube addons enable metrics-server
	minikube addons enable dashboard &
	#minikube addons enable dashboard &> /dev/null

	eval $(minikube docker-env)

	echo "🌟  The 'dashboard' addon is enabled"
	minikube addons enable metallb
	kubectl get configmap kube-proxy -n kube-system -o yaml | \
	sed -e 's/strictARP: false/strictARP: true/' -e 's/mode: ""/mode: "ipvs"/' | \
	kubectl apply -f - -n kube-system
	#Installation by manifest
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml

	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
	kubectl apply -f srcs/metallb-config.yaml
	
	#kubectl apply -f srcs/metallb-config.yaml &> /dev/null
	echo "🌟  The MetalLB has been configured"
	
	echo -en $GREEN
	echo "Minikube is ready !"
	echo

build_img nginx

build_service nginx