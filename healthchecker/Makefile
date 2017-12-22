TAG=v1
IMAGE=andrewwebber/healthchecker

all: push

build:
	docker build --pull -t $(IMAGE):$(TAG) .

push: build
	docker push $(IMAGE):$(TAG)
