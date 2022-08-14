IMAGE_NAME:=kaichao/wdt
PROXY_SERVER:=10.255.128.1

build:
	docker build --network=host \
		--build-arg http_proxy=http://$(PROXY_SERVER):8118 \
		--build-arg https_proxy=http://$(PROXY_SERVER):8118 \
		-t $(IMAGE_NAME) .

push:
	docker push $(IMAGE_NAME)
