export IMAGE ?= dsv_dev

SERVICE := dsv_dev
SYSTEM_NETWORK := dsv_dev

build: create-networks
	docker build \
		--build-arg GITHUB_USER=$(GITHUB_USER) \
		--build-arg GITHUB_TOKEN=$(GITHUB_TOKEN) \
		--build-arg DSV_CONFIGURATION_FILE=$(DSV_CONFIGURATION_FILE) \
		--progress=plain \
		-t $(IMAGE) -f Dockerfile . ;
#	@docker build --no-cache -t $(IMAGE) -f docker/Dockerfile . ;

shell: build
	docker run --rm -it --init \
		--volume=$(PWD):/workspace \
		--network=host \
		$(IMAGE) /bin/bash

test: build
	docker run --rm -it --init \
		--volume=$(PWD):/workspace \
		--network=host \
		$(IMAGE) sh ./scripts/run_tests.sh


create-networks:
	@docker network create $(SYSTEM_NETWORK) > /dev/null 2>&1 || true