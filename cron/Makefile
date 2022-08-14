CRON_TAGS ?= latest python-3.10 postgres-14 openjre-11 redis-6 rsync-3.2.3

ifeq ($(TAG), openjre-11)
  BASE_IMAGE := openjdk:11-jre-bullseye
else ifeq ($(TAG), python-3.10)
  BASE_IMAGE := python:3.10-slim-bullseye
else ifeq ($(TAG), redis-6)
  BASE_IMAGE := redis:6-bullseye
else ifeq ($(TAG), postgres-14)
  BASE_IMAGE := hub.cstcloud.cn/scalebox/postgres
else ifeq ($(TAG), rsync-3.2.3)
  BASE_IMAGE := hub.cstcloud.cn/scalebox/rsync:3.2.3
else
  BASE_IMAGE := debian:11-slim
  TAG := latest
endif

IMAGE_NAME := hub.cstcloud.cn/scalebox/cron:$(TAG)

build:
	docker build --network=host --build-arg BASE_IMAGE=$(BASE_IMAGE) --tag $(IMAGE_NAME) .

push:
	docker push $(IMAGE_NAME)

clean:
	docker rmi $(IMAGE_NAME)

run:
	docker run -it --rm --privileged $(IMAGE_NAME) bash

start:
	 docker run -d --name cron-job -e CRON_MINUTES=2 --rm --privileged $(IMAGE_NAME)

build-all:
	@for tag in $(CRON_TAGS); do  TAG=$$tag make build; done

push-all:
	@for tag in $(CRON_TAGS); do  TAG=$$tag make push; done

