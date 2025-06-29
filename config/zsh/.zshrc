# ~/.zshrc - Enhanced Zsh Configuration for Productivity

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="mh"

# Plugin Configuration - Keep minimal for fast startup
plugins=(
  git
  z
  docker
  brew
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Load additional configuration files
[[ -f ~/.config/zsh/exports.zsh ]] && source ~/.config/zsh/exports.zsh
[[ -f ~/.config/zsh/aliases.zsh ]] && source ~/.config/zsh/aliases.zsh
[[ -f ~/.config/zsh/functions.zsh ]] && source ~/.config/zsh/functions.zsh

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

# Directory navigation
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt CDABLE_VARS

# Completion improvements
setopt COMPLETE_ALIASES
setopt AUTO_LIST
setopt AUTO_MENU
setopt ALWAYS_TO_END

# Error correction
setopt CORRECT
setopt CORRECT_ALL

# Key bindings for productivity
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

# FZF integration
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --color=bg+:#264f78,bg:#1e1e1e,fg:#d4d4d4,fg+:#ffffff,hl:#0dbc79,hl+:#23d18b'
  export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
  export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
fi

# Load machine-specific customizations if they exist
[[ -f ~/.zsh_local ]] && source ~/.zsh_local

# Load Powerlevel10k configuration
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh