#image creation
build_img() {
    echo "Building $1 image."
    docker build -t "$1-img" "srcs/$1"
    echo 
}

build_img nginx