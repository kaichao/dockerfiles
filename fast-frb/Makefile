build:
	docker build --network=host -t fast/heimdall .

run:
	docker run -it --network=host --rm --gpus device=1 -v ${PWD}/data:/data --entrypoint bash fast/heimdall

run-fifo-worker:
	docker run -d --network=host --rm --gpus device=1 -v ${PWD}/data:/data -v ${PWD}/bin:/app/bin \
		--entrypoint fifo-worker.sh start_huntting.py 1 fast/heimdall

run-fifo:
	for i in {0..7}; do \
		docker run -d --network=host --rm --gpus device=$$i -v ${PWD}/data:/data -v ${PWD}/bin:/app/bin \
			--entrypoint fifo-worker.sh start_huntting.py $$i fast/heimdall; \
	done

run-sock-worker:
	docker run -d --network=host --rm --gpus device=1 -v ${PWD}/data:/data -v ${PWD}/bin:/app/bin \
		fast/heimdall start_huntting.py 1

run-sock:
	for i in {0..7}; do \
		docker run -d --network=host --rm --gpus device=$$i -v ${PWD}/data:/data -v ${PWD}/bin:/app/bin \
			 fast/heimdall start_huntting.py $$i; \
	done
