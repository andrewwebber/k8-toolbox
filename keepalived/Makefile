all: build

build: tools docker-push

tools: bin/network-interface bin/setup-network-environment

bin/network-interface:
	@go get github.com/andrewwebber/k8-toolbox/network-interface
	@go build -o ./container/network-interface github.com/andrewwebber/k8-toolbox/network-interface

bin/setup-network-environment:
	@go get github.com/kelseyhightower/setup-network-environment
	@go build -o ./container/setup-network-environment github.com/kelseyhightower/setup-network-environment

docker-image:
	@docker build -t andrewwebber/keepalived ./container

docker-push: docker-image
	@docker push andrewwebber/keepalived
