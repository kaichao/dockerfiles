IMAGE_NAME:=scalebox/cron-test:openjre-11
CONTAINER_NAME:=cron-job-java

build:
	docker build --network=host -t $(IMAGE_NAME) .

run:
	docker run -it --rm --privileged $(IMAGE_NAME) bash

start:
	docker run -d --name $(CONTAINER_NAME) -e CRON_MINUTES=2 --rm --privileged $(IMAGE_NAME)
# docker run -d --name $(CONTAINER_NAME) -e CRON_MINUTES=60 -e CRON_HOURS=2 --rm --privileged $(IMAGE_NAME)

exec:
	docker exec -it $(CONTAINER_NAME) bash

cat:
	docker exec -it $(CONTAINER_NAME) cat /var/log/cron.log

clean:
	docker kill $(CONTAINER_NAME) || true
	docker rmi $(IMAGE_NAME)
