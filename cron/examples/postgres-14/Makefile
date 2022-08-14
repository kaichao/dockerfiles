IMAGE_NAME:=scalebox/cron-test:postgres-14
CONTAINER_NAME:=cron-job-postgres

build:
	docker-compose build

run:
	docker-compose up

start:
	docker-compose up -d

exec:
	docker exec -it $(CONTAINER_NAME) bash

cat:
	docker exec -it $(CONTAINER_NAME) cat /var/log/cron.log

clean:
	docker kill $(CONTAINER_NAME) || true
	docker rmi $(IMAGE_NAME)
