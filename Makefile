DIRS ?= docker-cli envoy-grpc-proxy postgres rsyncd wdt

build-all:
	@for d in $(DIRS); do make -C $$d build; done

push-all:
	@for d in $(DIRS); do make -C $$d push; done

sync:
	# rsync -av . fast:/home/kaichao/dockerfiles
	rsync -av . scalebox@h12:/tmp/dockerfiles
	date
