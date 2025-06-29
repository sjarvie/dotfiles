#!/bin/bash

# Application Installation Script
# Installs productivity apps optimized for development workflow

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[APPS]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[APPS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[APPS]${NC} $1"
}

# Install essential development tools via Homebrew
install_cli_tools() {
    log_info "Installing command line tools..."
    
    local tools=(
        "git"
        "curl"
        "wget"
        "tree"
        "jq"
        "fd"
        "ripgrep"
        "bat"
        "eza"
        "dust"
        "bottom"
        "fzf"
        "delta"
        "gh"
        "node"
        "python@3.11"
        "pyenv"
        "rbenv"
        "go"
        "rust"
        "docker"
        "docker-compose"
        "neovim"
        "tmux"
        "htop"
        "watch"
        "mas"
        "z"
        "zoxide"
        "starship"
        "tldr"
        "httpie"
        "yq"
        "shellcheck"
        "shfmt"
        "glow"
        "slides"
    )
    
    for tool in "${tools[@]}"; do
        if brew list "$tool" &> /dev/null; then
            log_info "$tool already installed"
        else
            log_info "Installing $tool..."
            brew install "$tool"
            log_success "$tool installed"
        fi
    done
}

# Install GUI applications via Homebrew Cask
install_gui_apps() {
    log_info "Installing GUI applications..."
    
    local apps=(
        # Development
        "cursor"
        "visual-studio-code"
        "ghostty"
        "warp"
        "iterm2"
        
        # Productivity
        "raycast"
        "1password"
        "notion"
        "obsidian"
        "todoist"
        
        # Utilities
        "cleanmymac"
        "the-unarchiver"
        "finder-toolbar"
        "command-x"
        "hiddenbar"
        "stats"
        "latest"
        "appcleaner"
        
        # Communication
        "slack"
        "discord"
        "zoom"
        
        # Media
        "vlc"
        "spotify"
        "imageoptim"
        "keka"
        
        # Browsers
        "google-chrome"
        "firefox"
        "arc"
        
        # Design
        "figma"
        "sketch"
        
        # Miscellaneous
        "loom"
        "clockify"
        "dropzone"
    )
    
    for app in "${apps[@]}"; do
        if brew list --cask "$app" &> /dev/null; then
            log_info "$app already installed"
        else
            log_info "Installing $app..."
            if brew install --cask "$app"; then
                log_success "$app installed"
            else
                log_warning "Failed to install $app (may not be available)"
            fi
        fi
    done
}

# Install Mac App Store apps
install_mas_apps() {
    log_info "Installing Mac App Store applications..."
    
    # Check if mas is available
    if ! command -v mas &> /dev/null; then
        log_warning "mas not available, skipping App Store apps"
        return
    fi
    
    # Check if signed in to App Store
    if ! mas account &> /dev/null; then
        log_warning "Not signed in to App Store, skipping App Store apps"
        log_info "Sign in to the App Store and run 'mas install <app-id>' manually"
        return
    fi
    
    local mas_apps=(
        "497799835"   # Xcode
        "1295203466"  # Microsoft Remote Desktop
        "1289583905"  # Pixelmator Pro
        "1451685025"  # WireGuard
        "1147396723"  # WhatsApp Desktop
        "1153157709"  # Speedtest by Ookla
        "692867256"   # Simplenote
        "1475387142"  # Tailscale
    )
    
    for app_id in "${mas_apps[@]}"; do
        if mas list | grep -q "$app_id"; then
            log_info "App $app_id already installed"
        else
            log_info "Installing App Store app $app_id..."
            if mas install "$app_id"; then
                log_success "App $app_id installed"
            else
                log_warning "Failed to install app $app_id"
            fi
        fi
    done
}

# Install development languages and tools
install_development_tools() {
    log_info "Setting up development environments..."
    
    # Node.js via nvm
    if [[ ! -d "$HOME/.nvm" ]]; then
        log_info "Installing nvm..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        
        # Install latest LTS Node.js
        nvm install --lts
        nvm use --lts
        nvm alias default lts/*
        log_success "nvm and Node.js LTS installed"
    fi
    
    # Python packages
    if command -v pip3 &> /dev/null; then
        log_info "Installing Python packages..."
        pip3 install --user black flake8 pylint mypy pytest requests beautifulsoup4 numpy pandas matplotlib jupyter
        log_success "Python packages installed"
    fi
    
    # Global npm packages
    if command -v npm &> /dev/null; then
        log_info "Installing global npm packages..."
        npm install -g typescript @typescript-eslint/parser @typescript-eslint/eslint-plugin prettier eslint create-react-app @vue/cli @angular/cli next netlify-cli vercel serve http-server nodemon concurrently
        log_success "Global npm packages installed"
    fi
}

# Install fonts
install_fonts() {
    log_info "Installing productivity fonts..."
    
    # Add font cask if not already added
    if ! brew tap | grep -q "homebrew/cask-fonts"; then
        brew tap homebrew/cask-fonts
    fi
    
    local fonts=(
        "font-fira-code"
        "font-fira-code-nerd-font"
        "font-jetbrains-mono-nerd-font"
        "font-source-code-pro"
        "font-cascadia-code"
    )
    
    for font in "${fonts[@]}"; do
        if brew list --cask "$font" &> /dev/null; then
            log_info "$font already installed"
        else
            log_info "Installing $font..."
            brew install --cask "$font"
            log_success "$font installed"
        fi
    done
}

# Main function
main() {
    log_info "Starting application installation..."
    log_info "This may take a while depending on your internet connection"
    
    # Update Homebrew
    log_info "Updating Homebrew..."
    brew update
    
    # Install everything
    install_cli_tools
    install_gui_apps
    install_fonts
    install_development_tools
    install_mas_apps
    
    # Cleanup
    log_info "Cleaning up..."
    brew cleanup
    brew autoremove
    
    log_success "Application installation completed!"
    log_info "Some applications may require manual configuration"
    log_info "Restart your system to ensure all applications work properly"
}

main "$@"
