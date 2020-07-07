HEIMDALL_IMAGE ?= kaichao/fast-heimdall:nvidia-p100

build:
	docker build --network=host -t $(HEIMDALL_IMAGE) .

run:
	docker run -it --network=host --rm --gpus device=1 -v ${PWD}/data:/data --entrypoint bash $(HEIMDALL_IMAGE)

run-fifo-worker:
	docker run -d --network=host --rm --gpus device=1 -v ${PWD}/data:/data -v ${PWD}/bin:/app/bin \
		--entrypoint fifo-worker.sh start_huntting.py 1 $(HEIMDALL_IMAGE)

run-fifo:
	for i in {0..7}; do \
		docker run -d --network=host --rm --gpus device=$$i -v ${PWD}/data:/data -v ${PWD}/bin:/app/bin \
			--entrypoint fifo-worker.sh start_huntting.py $$i $(HEIMDALL_IMAGE); \
	done

run-sock-worker:
	docker run -d --network=host --rm --gpus device=1 -v ${PWD}/data:/data -v ${PWD}/bin:/app/bin \
		$(HEIMDALL_IMAGE) start_huntting.py 1

run-sock:
	for i in {0..7}; do \
		docker run -d --network=host --rm --gpus device=$$i -v ${PWD}/data:/data -v ${PWD}/bin:/app/bin \
			 $(HEIMDALL_IMAGE) start_huntting.py $$i; \
	done
