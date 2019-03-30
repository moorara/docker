name := tools
docker_image := moorara/$(name)

version ?= $(shell git rev-parse --short HEAD)
revision := $(shell git rev-parse --verify HEAD)
branch := $(shell git rev-parse --abbrev-ref HEAD)
build_time := $(shell date -u +%Y-%m-%dT%H:%M:%SZ)


.PHONY: docker
docker:
	@ docker build \
	    --build-arg version=$(version) \
	    --build-arg revision=$(revision) \
	    --build-arg build_time=$(build_time) \
			--tag $(docker_image):$(version) \
	    .

.PHONY: latest
latest:
	@ docker image tag $(docker_image):$(version) $(docker_image):latest
