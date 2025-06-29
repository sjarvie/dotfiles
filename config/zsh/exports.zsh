# Environment Variables and Exports

# Editor configuration
export EDITOR="cursor"
export VISUAL="cursor"
export PAGER="less"

# Development tools
export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null || echo "")
export GOPATH="$HOME/go"
export GOROOT="/usr/local/go"
export GOBIN="$GOPATH/bin"

# Node.js
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# Python
export PYENV_ROOT="$HOME/.pyenv"
if [[ -d $PYENV_ROOT/bin ]]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)" 2>/dev/null || true
fi

# Ruby
export RBENV_ROOT="$HOME/.rbenv"
if [[ -d $RBENV_ROOT/bin ]]; then
    export PATH="$RBENV_ROOT/bin:$PATH"
    eval "$(rbenv init -)" 2>/dev/null || true
fi

# Rust
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Less configuration
export LESS='-R -i -w -M -z-4'
export LESSHISTFILE='-'

# Bat (better cat)
export BAT_THEME="Visual Studio Dark+"

# Grep colors
export GREP_OPTIONS="--color=auto"
export GREP_COLOR="1;32"

# History
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTCONTROL=ignoreboth:erasedups

# Language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Development
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# macOS specific
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS="--no-quarantine"

# GPG
export GPG_TTY=$(tty)

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'