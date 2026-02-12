#!/bin/bash

has_session() {
    tmux has-session -t "$1" 2>/dev/null
    return $?
}

if ! has_session "whjc"; then
    PROJECTS_DIR="$HOME/dev/williamhjcho"
    tmux new-session -d -s whjc -n "dotfiles" -c "$HOME/dotfiles"
    tmux split-window -t "whjc:dotfiles" -h -d -c "$HOME/dotfiles"
    tmux split-window -t "whjc:dotfiles.1" -v -d -c "$HOME/dotfiles"
    tmux resize-pane -t "whjc:dotfiles.1" -L 100
    tmux send-keys -t "whjc:dotfiles.3" "nvim" C-m

    tmux new-window -d -t "whjc" -n "memories" -c "$PROJECTS_DIR/memories"
    tmux split-window -t "whjc:memories" -h -d -c "$PROJECTS_DIR/memories"
    tmux split-window -t "whjc:memories.1" -v -d -c "$PROJECTS_DIR/memories"
    tmux resize-pane -t "whjc:memories.1" -L 100
    tmux send-keys -t "whjc:memories.3" "nvim" C-m

    tmux new-window -d -t "whjc" -n "others" -c "$HOME/dev"

    # tmux select-window -t "whjc:dotfiles"
    tmux select-pane -t "whjc:dotfiles.3"
fi

# WORK="dev"
# if ! has_session "$WORK"; then
#   DEV_DIR="$HOME/dev"
#   tmux new-session -d -s "$WORK" -n "dev" -c "$DEV_DIR"
# fi

SESSION="${1:-whjc}"
if has_session "$SESSION"; then
    tmux attach-session -t "$SESSION"
else
    echo "Session '$SESSION' does not exist. Available sessions:"
    tmux list-sessions
    exit 1
fi
