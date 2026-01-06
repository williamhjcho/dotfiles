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

    tmux new-window -d -t "$WHJC:" -n "memories" -c "$PROJECTS_DIR/memories"
    tmux split-window -t "$PROJECTS_DIR:memories" -h -d -c "$PROJECTS_DIR/memories"
    tmux split-window -t "$PROJECTS_DIR:memories.1" -v -d -c "$PROJECTS_DIR/memories"
    tmux resize-pane -t "$PROJECTS_DIR:memories.1" -L 100
    tmux select-pane -t "$PROJECTS_DIR:memories.3"

    tmux new-window -d -t "$WHJC:" -n "others" -c "$PROJECTS_DIR"

    tmux select-pane -t "$WHJC:dotfiles.3"
fi

WORK="180s"
if ! has_session "$WORK"; then
    WORK_DIR="$HOME/dev/180s"
    tmux new-session -d -s "$WORK" -n "180s" -c "$WORK_DIR"

    tmux new-window -d -t "$WORK:" -n "cisne" -c "$WORK_DIR/cisne"
    tmux split-window -t "$WORK:cisne" -h -d -c "$WORK_DIR/cisne"
    tmux split-window -t "$WORK:cisne.1" -v -d -c "$WORK_DIR/cisne"
    tmux resize-pane -t "$WORK:cisne.1" -L 100
    tmux select-pane -t "$WORK:cisne.3"

    tmux new-window -d -t "$WORK:" -n "camaleao" -c "$WORK_DIR/camaleao"
    tmux new-window -d -t "$WORK:" -n "tatu" -c "$WORK_DIR/tatu"

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
