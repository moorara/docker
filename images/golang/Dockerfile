# Tools Image
ARG TOOLS_VERSION=latest
FROM moorara/tools:$TOOLS_VERSION as tools

# Final Image
FROM golang:1.11

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
    apt-get upgrade -y && \
    apt-get install -y \
      ca-certificates netcat openssl openssh-server openssh-client \
      bash make vim git wget curl jq tar gzip zip unzip gnupg \
      ruby

# Clean up image
RUN rm -rf /tmp/* && \
    apt-get autoremove -y && \
    apt-get clean -y

# Copy tools
COPY --from=tools /usr/local/bin/docker          /usr/local/bin/docker
COPY --from=tools /usr/local/bin/docker-compose  /usr/local/bin/docker-compose
COPY --from=tools /usr/local/bin/kubectl         /usr/local/bin/kubectl
COPY --from=tools /usr/local/bin/helm            /usr/local/bin/helm
COPY --from=tools /usr/local/bin/shellcheck      /usr/local/bin/shellcheck
COPY --from=tools /usr/local/bin/test-reporter   /usr/local/bin/test-reporter
COPY --from=tools /usr/local/bin/cherry          /usr/local/bin/cherry

# Install gometalinter
RUN curl -sL https://git.io/vp6lP | sh

# Install github changelog generator
RUN gem install github_changelog_generator
