build:
	docker run --rm -v ${PWD}:/sock-server golang:1.14 sh -c "cd /sock-server && go build"

run:
	scp job-server* root@kube-master:/tmp
	ssh root@kube-master chmod +x /tmp/sock-server
	ssh root@kube-master /tmp/sock-server

clean:
	rm -f sock-server

