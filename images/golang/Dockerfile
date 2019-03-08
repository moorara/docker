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
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
      ca-certificates netcat openssl openssh-server openssh-client \
      bash make vim git wget curl jq tar gzip zip unzip gnupg \
      ruby python python-pip && \
      apt-get autoremove -y && \
      apt-get clean -y && \
      rm -rf /var/lib/apt/lists/* /tmp/*

# Install gometalinter
RUN curl -sL https://git.io/vp6lP | sh

# Docker tools
COPY --from=tools /usr/local/bin/docker /usr/local/bin/docker
COPY --from=tools /usr/local/bin/docker-compose /usr/local/bin/docker-compose

# Kubernetes tools
COPY --from=tools /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY --from=tools /usr/local/bin/helm /usr/local/bin/helm
COPY --from=tools /usr/local/bin/kustomize /usr/local/bin/kustomize
COPY --from=tools /usr/local/bin/draft /usr/local/bin/draft
COPY --from=tools /usr/local/bin/skaffold /usr/local/bin/skaffold

# Misc tools
COPY --from=tools /usr/local/bin/shellcheck /usr/local/bin/shellcheck
RUN pip install yamllint

# SaaS command-line tools
COPY --from=tools /usr/local/bin/test-reporter /usr/local/bin/test-reporter
COPY --from=tools /usr/local/bin/circleci /usr/local/bin/circleci

# Install Cherry (and github-changelog-generator)
RUN gem install github_changelog_generator && \
    curl -s https://raw.githubusercontent.com/moorara/cherry/master/scripts/install.sh | bash
