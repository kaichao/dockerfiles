IMAGE_NAME:=kaichao/rsyncd

build:
	docker build --network=host -t $(IMAGE_NAME) .

push:
	docker push $(IMAGE_NAME)

run:
	docker run -d --rm -p 873:873 -v /etc/localtime:/etc/localtime:ro -v /var/log:/var/log -v /opt/fast/frb:/frb -v /opt/fast/datavolume/doi:/doi -v /opt/files:/files -e TZ=CST-8 $(IMAGE_NAME) 
