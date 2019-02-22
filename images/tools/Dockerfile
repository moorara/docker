FROM alpine:3.9

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
RUN apk add --no-cache \
      ca-certificates openssl openssh openssh-client \
      bash make git wget curl jq tar gzip xz gnupg

# Required for running docker-compose
RUN GLIBC=2.28-r0 && \
    apk add --no-cache libgcc && \
    curl -fsSL -o /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    curl -fsSL -o glibc-$GLIBC.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC/glibc-$GLIBC.apk && \
    apk add --no-cache glibc-$GLIBC.apk && \
    ln -s /lib/libz.so.1 /usr/glibc-compat/lib/ && \
    ln -s /lib/libc.musl-x86_64.so.1 /usr/glibc-compat/lib && \
    ln -s /usr/lib/libgcc_s.so.1 /usr/glibc-compat/lib && \
    rm /etc/apk/keys/sgerrand.rsa.pub glibc-$GLIBC.apk

# Install pipeline tools
COPY scripts /scripts
RUN /scripts/install-docker.sh && \
    /scripts/install-compose.sh && \
    /scripts/install-kubectl.sh && \
    /scripts/install-helm.sh && \
    /scripts/install-shellcheck.sh && \
    /scripts/install-test-reporter.sh

# Install github changelog generator
RUN apk add --no-cache ruby ruby-json && \
    gem install rdoc --no-document && \
    gem install github_changelog_generator

# Install Cherry
RUN curl -s https://raw.githubusercontent.com/moorara/cherry/master/scripts/install.sh | bash
