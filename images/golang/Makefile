name := golang
docker_image := moorara/$(name)

version ?= latest
revision := $(shell git rev-parse --short HEAD)
build_time := $(shell date -u +%Y-%m-%dT%H:%M:%SZ)


docker:
	@ docker build \
	    --build-arg VERSION=$(version) \
	    --build-arg REVISION=$(revision) \
	    --build-arg BUILD_TIME=$(build_time) \
			--tag $(docker_image):$(version) \
	    .

push:
	@ docker push $(docker_image):$(version)


.PHONY: docker push
