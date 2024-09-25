#!/bin/bash

SESH="whjc"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then
  tmux new-session -d -s $SESH -n "dotfiles"
  tmux send-keys -t $SESH:dotfiles "cd ~/dotfiles" C-m
  tmux send-keys -t $SESH:dotfiles "nvim ." C-m

  tmux new-window -t $SESH -n "backend"
  tmux send-keys -t $SESH:backend "cd ~/dev/porfin/backend" C-m
  tmux send-keys -t $SESH:backend "nvim ." C-m
  tmux split-window -t $SESH:backend -h -d

  tmux new-window -t $SESH -n "functions"
  tmux send-keys -t $SESH:functions "cd ~/dev/porfin/cloud-functions" C-m
  tmux send-keys -t $SESH:functions "nvim ." C-m
  tmux split-window -t $SESH:functions -h -d

  tmux new-window -t $SESH -n "iac"
  tmux send-keys -t $SESH:iac "cd ~/dev/porfin/iac" C-m
  tmux send-keys -t $SESH:iac "nvim ." C-m
  tmux split-window -t $SESH:iac -h -d

  tmux new-window -t $SESH -n "porfin-ai"
  tmux send-keys -t $SESH:porfin-ai "cd ~/dev/porfin/crew" C-m
  tmux send-keys -t $SESH:porfin-ai "nvim ." C-m
  tmux split-window -t $SESH:porfin-ai -h -d

  tmux select-window -t $SESH:dotfiles
fi

tmux attach-session -t $SESH
