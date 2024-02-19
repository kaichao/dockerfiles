IMAGE_NAME:=kaichao/rocm-runtime_ubuntu-1804

build:
	DOCKER_BUILDKIT=1 docker build --network=host --build-arg ROCM_VERSION=4.0.1 -t $(IMAGE_NAME):4.0.1 .

dist:
	# docker save $(IMAGE_NAME) | zstdmt | pv | ssh c0 'zstd -d | docker load'

push:
	docker push $(IMAGE_NAME):4.0.1

clean:
	docker rmi $(IMAGE_NAME)
