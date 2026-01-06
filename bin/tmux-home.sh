#!/bin/bash

has_session() {
    tmux has-session -t "$1" 2>/dev/null
    return $?
}

WHJC="whjc"
if ! has_session "$WHJC"; then
    PROJECTS_DIR="$HOME/dev/williamhjcho"
    tmux new-session -d -s $WHJC -n "dotfiles" -c "$HOME/dotfiles"
    tmux split-window -t "$WHJC:dotfiles" -h -d -c "$HOME/dotfiles"
    tmux split-window -t "$WHJC:dotfiles.1" -v -d -c "$HOME/dotfiles"
    tmux resize-pane -t "$WHJC:dotfiles.1" -L 100
    tmux send-keys -t "$WHJC:dotfiles.3" "nvim" C-m

    tmux new-window -d -t "$WHJC" -n "memories" -c "$PROJECTS_DIR/memories"
    tmux split-window -t "$WHJC:memories" -h -d -c "$PROJECTS_DIR/memories"
    tmux split-window -t "$WHJC:memories.1" -v -d -c "$PROJECTS_DIR/memories"
    tmux resize-pane -t "$WHJC:memories.1" -L 100
    tmux send-keys -t "$WHJC:memories.3" "nvim" C-m

    tmux new-window -d -t "$WHJC" -n "others" -c "$PROJECTS_DIR"

    # tmux select-window -t "$WHJC:dotfiles"
    tmux select-pane -t "$WHJC:dotfiles.3"
fi

# WORK="dev"
# if ! has_session "$WORK"; then
#   DEV_DIR="$HOME/dev"
#   tmux new-session -d -s "$WORK" -n "dev" -c "$DEV_DIR"
# fi

SESSION="${1:-$WHJC}"
if has_session "$SESSION"; then
    tmux attach-session -t "$SESSION"
else
    echo "Session '$SESSION' does not exist. Available sessions:"
    tmux list-sessions
    exit 1
fi
