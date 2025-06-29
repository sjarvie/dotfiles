# Productivity Functions

# Create a new directory and enter it
mkcd() {
  mkdir -p "$@" && cd "$_"
}

# Extract archives with one command
extract() {
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar e "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Find and replace in files
fnd() {
  grep -r "$1" "${2:-.}" --include="*.${3:-*}"
}

# Quick project switcher using fzf
proj() {
  local project_dir="${HOME}/Projects"
  if [ ! -d "$project_dir" ]; then
    project_dir="${HOME}/Developer"
  fi
  
  if [ ! -d "$project_dir" ]; then
    echo "No project directory found"
    return 1
  fi
  
  local project=$(fd -t d -d 2 . "$project_dir" | fzf --height 40% --reverse)
  if [ -n "$project" ]; then
    cd "$project"
  fi
}

# Quick note taking
note() {
  local note_dir="$HOME/Notes"
  mkdir -p "$note_dir"
  
  if [ $# -eq 0 ]; then
    local note_file="$note_dir/$(date +%Y-%m-%d).md"
  else
    local note_file="$note_dir/$1.md"
  fi
  
  cursor "$note_file"
}

# Git branch switcher with fzf
gbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# Kill process by name
killp() {
  local pid
  if [ "$UID" != "0" ]; then
    pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
  else
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  fi
  
  if [ "x$pid" != "x" ]; then
    echo "$pid" | xargs kill -${1:-9}
  fi
}

# Weather function
weather() {
  curl -s "wttr.in/${1:-}" | head -n -3
}

# Create a backup of a file
backup() {
  cp "$1"{,.bak.$(date +%Y%m%d_%H%M%S)}
}

# Quick server for current directory
server() {
  local port="${1:-8000}"
  if command -v python3 >/dev/null 2>&1; then
    python3 -m http.server "$port"
  else
    python -m SimpleHTTPServer "$port"
  fi
}

# JSON pretty print
jsonify() {
  if [ -t 0 ]; then
    python3 -m json.tool <<< "$*"
  else
    python3 -m json.tool
  fi
}

# URL encode/decode
urlencode() {
  python3 -c "import urllib.parse; print(urllib.parse.quote('''$1'''))"
}

urldecode() {
  python3 -c "import urllib.parse; print(urllib.parse.unquote('''$1'''))"
}

# Quick docker cleanup
dcleanup() {
  echo "Cleaning up Docker containers, images, and volumes..."
  docker system prune -af
  docker volume prune -f
}

# Git commit with conventional commits
gcommit() {
  local type="${1:-feat}"
  local scope="$2"
  local message="$3"
  
  if [ -z "$message" ]; then
    echo "Usage: gcommit <type> [scope] <message>"
    echo "Types: feat, fix, docs, style, refactor, test, chore"
    return 1
  fi
  
  if [ -n "$scope" ]; then
    git commit -m "${type}(${scope}): ${message}"
  else
    git commit -m "${type}: ${message}"
  fi
}

# Quick project init
init-project() {
  local project_name="$1"
  if [ -z "$project_name" ]; then
    echo "Usage: init-project <project-name>"
    return 1
  fi
  
  mkdir -p "$project_name"
  cd "$project_name"
  
  git init
  touch README.md
  echo "# $project_name" > README.md
  echo "node_modules/" > .gitignore
  echo ".env" >> .gitignore
  echo ".DS_Store" >> .gitignore
  
  git add .
  git commit -m "chore: initial commit"
  
  echo "Project '$project_name' initialized!"
}

# File size in human readable format
fs() {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh
  else
    local arg=-sh
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@"
  else
    du $arg .[^.]* ./*
  fi
}

# Compare original and gzipped file size
gz() {
  local origsize=$(wc -c < "$1")
  local gzipsize=$(gzip -c "$1" | wc -c)
  local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l)
  printf "orig: %d bytes\n" "$origsize"
  printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio"
}

# Quick chmod
chmodx() {
  chmod +x "$@"
}