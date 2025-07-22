#!/bin/bash

set -e

function have {
  command -v "$1" &>/dev/null
}

have ansible || {
  echo "Ansible not installed"
  exit 1
}

TAGS=""
while [[ $# -gt 0 ]]; do
  case "$1" in
  --dotfiles | --zsh | --homebrew | --dock)
    TAG="${1#--}"
    TAGS="${TAGS:+$TAGS,}$TAG"
    ;;
  *)
    echo "Unknown option: '$1'"
    exit 1
    ;;
  esac
  shift
done

echo "running ansible: ${TAGS:+(tags: $TAGS)}"

ansible-playbook ./macos.yaml \
  --inventory ./inventory \
  --ask-become-pass \
  ${TAGS:+--tags "$TAGS"}
