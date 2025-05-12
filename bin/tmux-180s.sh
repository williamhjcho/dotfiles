#!/bin/bash

has_session() {
  tmux has-session -t "$1" 2>/dev/null
  return $?
}

WHJC="whjc"
if ! has_session "$WHJC"; then
  tmux new-session -d -s $WHJC -n "dotfiles" -c "$HOME/dotfiles"
  tmux send-keys -t "$WHJC:dotfiles" "nvim" C-m
  tmux split-window -t "$WHJC:dotfiles" -h -d -c "$HOME/dotfiles"
  tmux select-window -t "$WHJC:dotfiles"
fi

WORK="180s"
if ! has_session "$WORK"; then
  WORK_DIR="$HOME/dev/180s"
  tmux new-session -d -s "$WORK" -n "180s" -c "$WORK_DIR"

  tmux new-window -t "$WORK" -n "cisne" -c "$WORK_DIR/cisne"

  # tmux new-window -t "$WORK" -n "<project-name>" -c "$WORK_DIR/<dir>"
  # tmux split-window -t "$WORK:<project-name>" -h -d -c "$WORK_DIR/<dir>"
fi

SESSION="${1:-$WHJC}"
if has_session "$SESSION"; then
  tmux attach-session -t "$SESSION"
else
  echo "Session '$SESSION' does not exist. Available sessions:"
  tmux list-sessions
  exit 1
fi
