# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# https://denysdovhan.com/spaceship-prompt/#installing
# ZSH_THEME="spaceship"
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-nvm)

source $ZSH/oh-my-zsh.sh

# Personal configurations start
export XDG_CONFIG_HOME="$HOME/.config"
export DEV_HOME="$HOME/dev"
export TOOLS_HOME="$HOME/tools"
export EDITOR=nvim

# zsh
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

# SSH/GPG
#export GPG_TTY=$(tty)

# User configurations
# export PATH="$PATH:/usr/local/sbin"
# export PATH="$GOPATH:$PATH"
# export PATH="/usr/local/opt/openjdk@11/bin:$PATH"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# brew autocompletion
if type brew &>/dev/null
then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi

# npm
export PATH="$NPM_BIN:$PATH"

# Android
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/tools/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

# Flutter
export PATH="$PATH":"$TOOLS_HOME/flutter/bin"
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Rust
export PATH="$PATH:$HOME/.cargo/bin"
[ -d "$HOME/.cargo" ] && . "$HOME/.cargo/env"

# Google Cloud CLI
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$TOOLS_HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$TOOLS_HOME/google-cloud-sdk/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "$TOOLS_HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$TOOLS_HOME/google-cloud-sdk/completion.zsh.inc"; fi

# Rover
[ -d "$HOME/.rover" ] && source "$HOME/.rover/env"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# aliases
alias zshconfig="nvim ~/.zshrc"
alias lll='ls -l'
alias lla='ls -la'
alias vim='nvim'

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Ruby
eval "$(rbenv init - zsh)"

# direnv
eval "$(direnv hook zsh)"

# bun completions
[ -s "/Users/williamhjcho/.bun/_bun" ] && source "/Users/williamhjcho/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# zsh plugins
if type brew &>/dev/null; then
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi
