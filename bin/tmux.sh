#!/bin/bash

SESH="whjc"
PORFIN="$HOME/dev/porfin"
WHJC="$HOME/dev/williamhjcho"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then
  tmux new-session -d -s $SESH -n "dotfiles" -c "$HOME/dotfiles"
  tmux send-keys -t $SESH:dotfiles "nvim ." C-m
  tmux split-window -t $SESH:dotfiles -h -d -c "$HOME/dotfiles"

  tmux new-window -t $SESH -n "backend" -c "$PORFIN/backend"
  tmux split-window -t $SESH:backend -h -d -c "$PORFIN/backend"

  tmux new-window -t $SESH -n "functions" -c "$PORFIN/cloud-functions"
  tmux split-window -t $SESH:functions -h -d -c "$PORFIN/cloud-functions"

  tmux new-window -t $SESH -n "iac" -c "$PORFIN/iac"
  tmux split-window -t $SESH:iac -h -d -c "$PORFIN/iac"

  tmux new-window -t $SESH -n "porfin-cloud" -c "$PORFIN/porfin-cloud"
  tmux split-window -t $SESH:porfin-cloud -h -d -c "$PORFIN/porfin-cloud"

  tmux new-window -t $SESH -n "vs" -c "$WHJC/vs"

  tmux select-window -t $SESH:dotfiles
fi

tmux attach-session -t $SESH
