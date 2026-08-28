#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
        --dotfiles | --zsh | --homebrew | --dock | --macos | --tmux)
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

needs_become_pass() {
    # Full run includes untagged roles/tasks that require sudo (e.g. CLI tools, homebrew setup).
    [[ -z "$TAGS" ]] && return 0

    local tag
    IFS=',' read -r -a selected <<< "$TAGS"
    for tag in "${selected[@]}"; do
        case "$tag" in
            zsh | macos) return 0 ;;
        esac
    done
    return 1
}

ANSIBLE_ARGS=(
    ansible-playbook "$SCRIPT_DIR/macos.yaml"
    --inventory "$SCRIPT_DIR/inventory"
)
if needs_become_pass; then
    ANSIBLE_ARGS+=(--ask-become-pass)
fi
if [[ -n "$TAGS" ]]; then
    ANSIBLE_ARGS+=(--tags "$TAGS")
fi

"${ANSIBLE_ARGS[@]}"
