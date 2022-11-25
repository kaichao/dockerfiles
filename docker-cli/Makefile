IMAGE_NAME:=kaichao/docker-cli

build:
	docker build --network=host -t $(IMAGE_NAME) .

push:
	docker push $(IMAGE_NAME)

run:
	# docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock $(IMAGE_NAME) bash
	docker run -it --rm -v ${PWD}:/src -w /src -v /var/run/docker.sock:/var/run/docker.sock $(IMAGE_NAME) bash
