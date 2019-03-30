# Final Image
FROM golang:1.12

ARG version
ARG revision
ARG build_time

LABEL repository="https://github.com/moorara/docker" \
      homepage="https://github.com/moorara/docker" \
      maintainer="Milad Irannejad"

LABEL org.opencontainers.image.version="$version" \
      org.opencontainers.image.revision="$revision" \
      org.opencontainers.image.created="$build_time" \
      org.opencontainers.image.source="https://github.com/moorara/docker/tree/master/images/golang"

# Install must-have tools
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      ca-certificates netcat openssl openssh-server openssh-client \
      bash make vim git wget curl jq tar gzip zip unzip gnupg && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/*

COPY scripts /scripts

# Install linter
RUN /scripts/install-golangci-lint.sh

# Install gRPC tools
RUN /scripts/install-protoc.sh && \
    go get -u google.golang.org/grpc && \
    go get -u github.com/golang/protobuf/protoc-gen-go && \
    go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway && \
    go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger

# Install Code Climate test-reporter
RUN curl -fsSL -o /usr/local/bin/test-reporter https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 && \
    chmod 755 /usr/local/bin/test-reporter

# Install Cherry
RUN curl -s https://raw.githubusercontent.com/moorara/cherry/master/scripts/install.sh | bash
