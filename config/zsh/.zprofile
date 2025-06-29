# ~/.zprofile - Login shell configuration

# Homebrew
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Add common paths
typeset -U path
path=(
  /usr/local/bin
  /usr/local/sbin
  /opt/homebrew/bin
  /opt/homebrew/sbin
  ~/.local/bin
  ~/bin
  ~/.cargo/bin
  ~/.go/bin
  $path
)

# Load exports
source ~/.config/zsh/exports.zsh