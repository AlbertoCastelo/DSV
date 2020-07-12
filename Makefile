export IMAGE ?= dsgit_dev

SERVICE := dsgit_dev
SYSTEM_NETWORK := dsgit_dev

build: create-networks
	docker build \
		--progress=plain \
		-t $(IMAGE) -f Dockerfile . ;
#	@docker build --no-cache -t $(IMAGE) -f docker/Dockerfile . ;

shell: build
	docker run --rm -it --init \
		--volume=$(PWD):/workspace \
		--network=host \
		$(IMAGE) /bin/bash
	# cd docker && (docker-compose run --service-ports $(SERVICE) /bin/bash) ;

test: build
	cd docker && (docker-compose run --service-ports $(SERVICE) /bin/bash scripts/run_tests.sh) ;

# jupyter: build
# 	echo $(PWD)
# 	docker run --rm -it --init \
# 		--gpus=all \
# 		--ipc=host \
# 		--user="$(id -u):$(id -g)" \
# 		--volume=$(PWD):/workspace \
# 		--network=host \
# 		$(IMAGE) jupyter lab --ip=0.0.0.0 --allow-root --no-browser

# 	# cd docker && (docker-compose run --service-ports $(SERVICE) )

create-networks:
	@docker network create $(SYSTEM_NETWORK) > /dev/null 2>&1 || true