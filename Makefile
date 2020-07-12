export IMAGE ?= dsgit_dev

SERVICE := dsgit_dev
SYSTEM_NETWORK := dsgit_dev

build: create-networks
	docker build \
		--build-arg GITHUB_USER=$(GITHUB_USER) \
		--build-arg GITHUB_TOKEN=$(GITHUB_TOKEN) \
		--build-arg DSGIT_CONFIGURATION_FILE=$(DSGIT_CONFIGURATION_FILE) \
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
	docker run --rm -it --init \
		--volume=$(PWD):/workspace \
		--network=host \
		$(IMAGE) sh /tests/get_template.sh


create-networks:
	@docker network create $(SYSTEM_NETWORK) > /dev/null 2>&1 || true