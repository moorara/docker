# Tools Image
ARG TOOLS_VERSION=latest
FROM moorara/tools:$TOOLS_VERSION as tools

# Final Image
FROM golang:1.12

ARG VERSION
ARG REVISION
ARG BUILD_TIME

LABEL repository="https://github.com/moorara/docker" \
      homepage="https://github.com/moorara/docker" \
      maintainer="Milad Irannejad"

LABEL org.opencontainers.image.version="$VERSION" \
      org.opencontainers.image.revision="$REVISION" \
      org.opencontainers.image.created="$BUILD_TIME" \
      org.opencontainers.image.source="https://github.com/moorara/docker"

# Install must-have tools
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      ca-certificates netcat openssl openssh-server openssh-client \
      bash make vim git wget curl jq tar gzip zip unzip gnupg && \
      apt-get autoremove -y && \
      apt-get clean -y && \
      rm -rf /var/lib/apt/lists/* /tmp/*

# Install gometalinter
RUN curl -sL https://git.io/vp6lP | sh

# SaaS command-line tools
COPY --from=tools /usr/local/bin/test-reporter /usr/local/bin/test-reporter

# Install Cherry
RUN curl -s https://raw.githubusercontent.com/moorara/cherry/master/scripts/install.sh | bash
