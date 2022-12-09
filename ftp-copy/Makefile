IMAGE_NAME:=kaichao/ftp-copy

build:
	docker build --network host -t $(IMAGE_NAME) .

push:
	docker push $(IMAGE_NAME)

run:
	docker run -it --network host --rm --privileged -v /:/local \
		-e REMOTE_URL=$${REMOTE_URL} $(IMAGE_NAME) bash
