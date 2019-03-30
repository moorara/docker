#!/usr/bin/env bash

#
# USAGE:
#   ./install-protoc.sh
#   ./install-protoc.sh -r v3.7.1
#   ./install-protoc.sh --release v3.7.1
#

set -euo pipefail


ensure_command() {
  for cmd in "$@"; do
    hash $cmd 2> /dev/null || (
      echo "$cmd not available!"
      exit 1
    )
  done
}

process_args() {
  while [ $# -gt 1 ]; do
    key=$1
    case $key in
      -r|--release)
      release="v$2"
      shift
      ;;
    esac
    shift
  done

  release=${release:-$(curl -s https://api.github.com/repos/protocolbuffers/protobuf/releases/latest | jq -r '.tag_name')}
  version=${release#v}
}

install_protoc() {
  echo "Installing protoc ${release} ..."

  os=linux
  arch=x86_64
  archive=./protoc.zip
  protoc=bin/protoc
  path=/usr/local/bin/protoc

  curl -fsSL "https://github.com/protocolbuffers/protobuf/releases/download/${release}/protoc-${version}-${os}-${arch}.zip" -o ${archive}
  unzip -p ${archive} ${protoc} > ${path}
  chmod +x ${path}

  echo "protoc ${release} installed successfully!"
}


ensure_command "curl" "jq"
process_args "$@"
install_protoc
