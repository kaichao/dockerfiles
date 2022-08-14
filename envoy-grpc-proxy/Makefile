IMAGE_NAME:=kaichao/envoy-grpc-proxy

build:
	docker build -t $(IMAGE_NAME) .

push:
	docker push $(IMAGE_NAME)

clean:
	docker rmi $(IMAGE_NAME)
