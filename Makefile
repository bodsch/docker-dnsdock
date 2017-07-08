
CONTAINER  := dnsdock
IMAGE_NAME := docker-dnsdock

build:
	docker build \
		--rm \
		--tag=$(IMAGE_NAME) .
	@echo Image tag: ${IMAGE_NAME}

clean:
	docker \
		rmi \
		${IMAGE_NAME}

run:
	docker run \
		--detach \
		--interactive \
		--tty \
		--publish=53:53 \
		--publish=53:53/udp \
		--publish=80:80 \
		--volume=/var/run/docker.sock:/var/run/docker.sock \
		--hostname=${CONTAINER} \
		--name=${CONTAINER} \
		$(IMAGE_NAME) \
		--nameserver="141.1.1.1:53" --verbose --http=":80"

shell:
	docker run \
		--rm \
		--interactive \
		--tty \
		--volume=/var/run/docker.sock:/var/run/docker.sock \
		--hostname=${CONTAINER} \
		--name=${CONTAINER} \
		--entrypoint "" \
		$(IMAGE_NAME) \
		/bin/sh

exec:
	docker exec \
		--interactive \
		--tty \
		${CONTAINER} \
		/bin/sh

stop:
	docker kill \
		${CONTAINER}

history:
	docker history \
		${IMAGE_NAME}

