# Productivity Aliases

# File system operations
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias lt="ls -ltr"
alias lh="ls -lh"
alias tree="tree -C"

# Directory navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias -- -="cd -"

# Quick directory access
alias dt="cd ~/Desktop"
alias dl="cd ~/Downloads"
alias doc="cd ~/Documents"
alias dev="cd ~/Developer"
alias proj="cd ~/Projects"
alias dots="cd ~/.config"

# File operations
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias mkdir="mkdir -pv"

# Git aliases (enhanced)
alias g="git"
alias gs="git status"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit --amend"
alias gp="git push"
alias gpl="git pull"
alias gf="git fetch"
alias gd="git diff"
alias gds="git diff --staged"
alias gb="git branch"
alias gba="git branch -a"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gm="git merge"
alias gr="git rebase"
alias gl="git log --oneline --graph --decorate"
alias gla="git log --oneline --graph --decorate --all"
alias gst="git stash"
alias gstp="git stash pop"
alias gsh="git show"
alias grh="git reset --hard"
alias grs="git reset --soft"
alias gclean="git clean -fd"
alias gwip="git add -A && git commit -m 'WIP'"
alias gunwip="git log -n 1 | grep -q -c WIP && git reset HEAD~1"

# Docker aliases
alias d="docker"
alias dc="docker-compose"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias di="docker images"
alias drm="docker rm"
alias drmi="docker rmi"
alias dprune="docker system prune -af"
alias dstop="docker stop \$(docker ps -aq)"
alias drmall="docker rm \$(docker ps -aq)"

# Modern replacements
if command -v eza >/dev/null 2>&1; then
  alias ls="eza --color=always --group-directories-first"
  alias ll="eza -la --color=always --group-directories-first"
  alias lt="eza -aT --color=always --group-directories-first"
fi

if command -v bat >/dev/null 2>&1; then
  alias cat="bat"
fi

if command -v fd >/dev/null 2>&1; then
  alias find="fd"
fi

if command -v rg >/dev/null 2>&1; then
  alias grep="rg"
fi

if command -v dust >/dev/null 2>&1; then
  alias du="dust"
fi

if command -v btm >/dev/null 2>&1; then
  alias top="btm"
fi

# Development tools
alias serve="python3 -m http.server"
alias jsonpp="python3 -m json.tool"
alias urlencode="python3 -c 'import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))'"
alias urldecode="python3 -c 'import sys, urllib.parse; print(urllib.parse.unquote(sys.argv[1]))'"

# Network
alias myip="curl -s ifconfig.me"
alias localip="ipconfig getifaddr en0"
alias ports="lsof -i -P -n | grep LISTEN"
alias ping="ping -c 5"

# System
alias reload="source ~/.zshrc"
alias editrc="cursor ~/.zshrc"
alias editaliases="cursor ~/.config/zsh/aliases.zsh"
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Quick file editing
alias vim="nvim"
alias vi="nvim"
alias edit="cursor"
alias zshconfig="cursor ~/.zshrc"
alias ohmyzsh="cursor ~/.oh-my-zsh"

# Utility
alias h="history"
alias j="jobs"
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# Homebrew
alias brewup="brew update && brew upgrade && brew cleanup"
alias brewinfo="brew leaves | xargs brew deps --installed --for-each | sed 's/^/$(brew --repository)\\/Library\\/Taps\\/homebrew\\/homebrew-core\\/Formula\\//'"

# macOS specific
alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
alias spotlight="sudo mdutil -i on / > /dev/null"
alias spotlightoff="sudo mdutil -i off / > /dev/null"

# Fun stuff
alias weather="curl -s wttr.in"
alias moon="curl -s wttr.in/Moon"