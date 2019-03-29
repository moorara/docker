tools_image := moorara/tools
golang_image := moorara/golang
node_image := moorara/node

branch = $(shell git rev-parse --abbrev-ref HEAD)
commit_sha := $(shell git rev-parse --verify HEAD)
version := $(shell git rev-parse --short HEAD)
build_time := $(shell date -u +%Y-%m-%dT%H:%M:%SZ)


.PHONY: build-tools
build-tools:
	cd images/tools && \
	docker image build \
	  --build-arg version="$(version)" \
	  --build-arg revision="$(commit_sha)" \
	  --build-arg build_time="$(build_time)" \
	  --tag "$(tools_image):$(version)" \
	  .

.PHONY: push-tools
push-tools:
	@ docker image tag "$(tools_image):$(version)" "$(tools_image):latest"
	docker image push "$(tools_image):$(version)"
	docker image push "$(tools_image):latest"


.PHONY: build-golang
build-golang:
	cd images/golang && \
	docker image build \
	  --build-arg TOOLS_VERSION="$(version)" \
	  --build-arg VERSION="$(version)" \
	  --build-arg REVISION="$(commit_sha)" \
	  --build-arg BUILD_TIME="$(build_time)" \
	  --tag "$(golang_image):$(version)" \
	  .

.PHONY: push-golang
push-golang:
	@ docker image tag "$(golang_image):$(version)" "$(golang_image):latest"
	docker image push "$(golang_image):$(version)"
	docker image push "$(golang_image):latest"


.PHONY: build-node
build-node:
	cd images/node && \
	docker image build \
	  --build-arg TOOLS_VERSION="$(version)" \
	  --build-arg VERSION="$(version)" \
	  --build-arg REVISION="$(commit_sha)" \
	  --build-arg BUILD_TIME="$(build_time)" \
	  --tag "$(node_image):$(version)" \
	  .

.PHONY: push-node
push-node:
	@ docker image tag "$(node_image):$(version)" "$(node_image):latest"
	docker image push "$(node_image):$(version)"
	docker image push "$(node_image):latest"
