#!/bin/bash

SESH="whjc"
PORFIN="$HOME/dev/porfin"
WHJC="$HOME/dev/williamhjcho"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then
  tmux new-session -d -s $SESH -n "dotfiles" -c "$HOME/dotfiles"
  tmux send-keys -t $SESH:dotfiles "nvim ." C-m
  tmux split-window -t $SESH:dotfiles -h -d -c "$HOME/dotfiles"

  tmux new-window -t $SESH -n "whjc.dev" -c "$WHJC/whjc.dev"

  tmux select-window -t "$SESH:dotfiles"
fi

tmux attach-session -t $SESH
