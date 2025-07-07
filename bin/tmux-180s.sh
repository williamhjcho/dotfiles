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
  tmux split-window -t "$WHJC:dotfiles" -h -d -c "$HOME/dotfiles"
  tmux resize-pane -t "$WHJC:dotfiles.1" -R 60

  tmux new-window -d -t "$WHJC" -n "vs" -c "$PROJECTS_DIR/vs"
  tmux split-window -t "$WHJC:vs" -h -d -c "$PROJECTS_DIR/vs"
  tmux resize-pane -t "$WHJC:vs.1" -R 60

  tmux new-window -d -t "$WHJC" -n "travelzine" -c "$PROJECTS_DIR/travelzine"
  tmux split-window -t "$WHJC:travelzine" -h -d -c "$PROJECTS_DIR/travelzine"
  tmux resize-pane -t "$WHJC:travelzine.1" -R 60

  tmux new-window -d -t "$WHJC" -n "goodnewz" -c "$PROJECTS_DIR/goodnewz.ai"
  tmux split-window -t "$WHJC:goodnewz" -h -d -c "$PROJECTS_DIR/goodnewz.ai"
  tmux resize-pane -t "$WHJC:goodnewz.1" -R 60

  tmux select-window -t "$WHJC:dotfiles"
fi

WORK="180s"
if ! has_session "$WORK"; then
  WORK_DIR="$HOME/dev/180s"
  tmux new-session -d -s "$WORK" -n "180s" -c "$WORK_DIR"

  tmux new-window -d -t "$WORK:" -n "cisne" -c "$WORK_DIR/cisne"
  tmux split-window -t "$WORK:cisne" -h -d -c "$WORK_DIR/cisne"
  tmux resize-pane -t "$WORK:cisne.1" -R 60

  tmux new-window -d -t "$WORK:" -n "camaleao" -c "$WORK_DIR/camaleao"
  tmux split-window -t "$WORK:camaleao" -h -d -c "$WORK_DIR/arraia"

  tmux new-window -d -t "$WORK:" -n "arraia" -c "$WORK_DIR/arraia"

  # needs the trailing ':' on the session's name
  # tmux new-window -t "$WORK:" -n "<project-name>" -c "$WORK_DIR/<dir>"
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
