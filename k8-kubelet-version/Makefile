TAG=v1
IMAGE=andrewwebber/k8-kubelet-version

all: push
	
build:
	docker build --pull -t $(IMAGE):$(TAG) .

push: build
	docker push $(IMAGE):$(TAG)
