FROM alpine:3.9

ARG version
ARG revision
ARG build_time

LABEL repository="https://github.com/moorara/docker" \
      homepage="https://github.com/moorara/docker" \
      maintainer="Milad Irannejad"

LABEL org.opencontainers.image.version="$version" \
      org.opencontainers.image.revision="$revision" \
      org.opencontainers.image.created="$build_time" \
      org.opencontainers.image.source="https://github.com/moorara/docker/tree/master/images/tools"

# Install must-have tools
RUN apk add --no-cache \
      ca-certificates openssl openssh openssh-client \
      coreutils bash make git wget curl jq tar gzip xz gnupg \
      python3 py-pip ruby ruby-json

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

COPY scripts /scripts
COPY hashicorp.asc /hashicorp.asc

# Install Docker tools
RUN /scripts/install-docker.sh && \
    /scripts/install-docker-compose.sh

# Install Kubernetes tools
RUN /scripts/install-kubectl.sh && \
    /scripts/install-helm.sh && \
    /scripts/install-kustomize.sh && \
    /scripts/install-draft.sh && \
    /scripts/install-skaffold.sh

# Install HashiCorp tools
RUN /scripts/install-hashicorp.sh --key hashicorp.asc --project packer && \
    /scripts/install-hashicorp.sh --key hashicorp.asc --project terraform && \
    /scripts/install-hashicorp.sh --key hashicorp.asc --project consul && \
    /scripts/install-hashicorp.sh --key hashicorp.asc --project vault && \
    /scripts/install-hashicorp.sh --key hashicorp.asc --project nomad

# Install Cloud command-line tools
RUN pip install awscli

# Install misc tools
RUN pip install yamllint && \
    /scripts/install-shellcheck.sh

# Install SaaS command-line tools
RUN curl -fLSs https://circle.ci/cli | bash && \
    /scripts/install-test-reporter.sh

# Install Cherry (and github-changelog-generator)
RUN gem install rdoc --no-document && \
    gem install github_changelog_generator && \
    curl -s https://raw.githubusercontent.com/moorara/cherry/master/scripts/install.sh | bash
