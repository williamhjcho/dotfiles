#!/bin/bash

has_session() {
    tmux has-session -t "$1" 2>/dev/null
    return $?
}

WORK="180s"
if ! has_session "$WORK"; then
    PROJECTS_DIR="$HOME/dev/williamhjcho"
    tmux new-session -d -s $WORK -n "dotfiles" -c "$HOME/dotfiles"
    tmux split-window -t "$WORK:dotfiles" -h -d -c "$HOME/dotfiles"
    tmux split-window -t "$WORK:dotfiles.1" -v -d -c "$HOME/dotfiles"
    tmux resize-pane -t "$WORK:dotfiles.1" -L 100
    tmux send-keys -t "$WORK:dotfiles.3" "nvim" C-m
    tmux select-pane -t "$WORK:dotfiles.3"

    WORK_DIR="$HOME/dev/180s"
    tmux new-window -d -s "$WORK" -n "180s" -c "$WORK_DIR"

    tmux new-window -d -t "$WORK:" -n "cisne" -c "$WORK_DIR/cisne"
    tmux split-window -t "$WORK:cisne" -h -d -c "$WORK_DIR/cisne"
    tmux split-window -t "$WORK:cisne.1" -v -d -c "$WORK_DIR/cisne"
    tmux resize-pane -t "$WORK:cisne.1" -L 100
    tmux select-pane -t "$WORK:cisne.3"

    tmux new-window -d -t "$WORK:" -n "channels" -c "$WORK_DIR/lobo"
    tmux split-window -t "$WORK:channels" -h -d -c "$WORK_DIR/camaleao"

    tmux new-window -d -t "$WORK:" -n "others" -c "$WORK_DIR"

    # needs the trailing ':' on the session's name
    # tmux new-window -t "$WORK:" -n "<project-name>" -c "$WORK_DIR/<dir>"
    # tmux split-window -t "$WORK:<project-name>" -h -d -c "$WORK_DIR/<dir>"
fi

SESSION="${1:-$WORK}"
if has_session "$SESSION"; then
    tmux attach-session -t "$SESSION"
else
    echo "Session '$SESSION' does not exist. Available sessions:"
    tmux list-sessions
    exit 1
fi
