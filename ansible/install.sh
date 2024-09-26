#!/bin/bash

set -e

function have {
  command -v "$1" &>/dev/null
}

have ansible || {
  echo "Ansible not installed"
  exit 1
}

ansible-playbook ./macos.yaml \
  --inventory ./inventory \
  --ask-become-pass

# add optional --tags to run specific sections, e.g.
# --tags "dotfiles,zsh"
