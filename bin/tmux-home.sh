#!/bin/bash

has_session() {
  tmux has-session -t "$1" 2>/dev/null
  return $?
}

WHJC="whjc"
if ! has_session "$WHJC"; then
  PROJECTS_DIR="$HOME/dev/williamhjcho"
  tmux new-session -d -s $WHJC -n "dotfiles" -c "$HOME/dotfiles"
  tmux send-keys -t "$WHJC:dotfiles" "nvim" C-m
  # tmux split-window -t "$WHJC:dotfiles" -h -d -c "$HOME/dotfiles"

  tmux new-window -t "$WHJC:" -n "whjc.dev" -c "$PROJECTS_DIR/whjc.dev"

  tmux select-window -t "$WHJC:dotfiles"
fi

WORK="dev"
if ! has_session "$WORK"; then
  DEV_DIR="$HOME/dev"
  tmux new-session -d -s "$WORK" -n "dev" -c "$DEV_DIR"
fi

SESSION="${1:-$WHJC}"
if has_session "$SESSION"; then
  tmux attach-session -t "$SESSION"
else
  echo "Session '$SESSION' does not exist. Available sessions:"
  tmux list-sessions
  exit 1
fi
