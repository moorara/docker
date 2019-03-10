# Final Image
FROM node:11.11

ARG VERSION
ARG REVISION
ARG BUILD_TIME

LABEL repository="https://github.com/moorara/docker" \
      homepage="https://github.com/moorara/docker" \
      maintainer="Milad Irannejad"

LABEL org.opencontainers.image.version="$VERSION" \
      org.opencontainers.image.revision="$REVISION" \
      org.opencontainers.image.created="$BUILD_TIME" \
      org.opencontainers.image.source="https://github.com/moorara/docker/tree/master/images/node"

# Install must-have tools
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      ca-certificates netcat openssl openssh-server openssh-client \
      bash make vim git wget curl jq tar gzip zip unzip gnupg && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# Install Code Climate test-reporter
RUN curl -fsSL -o /usr/local/bin/test-reporter https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 && \
    chmod 755 /usr/local/bin/test-reporter
