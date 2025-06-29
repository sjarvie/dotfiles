#!/bin/bash

# Font Installation Script
# Installs Fira Code and other productivity fonts

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[FONTS]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[FONTS]${NC} $1"
}

# Install fonts via Homebrew
install_fonts_homebrew() {
    log_info "Installing fonts via Homebrew..."
    
    # Add font cask if not already added
    if ! brew tap | grep -q "homebrew/cask-fonts"; then
        brew tap homebrew/cask-fonts
    fi
    
    # List of fonts to install
    local fonts=(
        "font-fira-code"
        "font-fira-code-nerd-font"
        "font-jetbrains-mono"
        "font-jetbrains-mono-nerd-font"
        "font-source-code-pro"
        "font-hack"
        "font-inconsolata"
        "font-cascadia-code"
        "font-cascadia-mono"
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

# Download and install Fira Code directly (fallback)
install_fira_code_direct() {
    log_info "Installing Fira Code directly..."
    
    local fonts_dir="$HOME/Library/Fonts"
    local temp_dir="/tmp/fira-code"
    local download_url="https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip"
    
    # Create temp directory
    mkdir -p "$temp_dir"
    cd "$temp_dir"
    
    # Download Fira Code
    log_info "Downloading Fira Code..."
    curl -L "$download_url" -o "fira-code.zip"
    
    # Extract archive
    log_info "Extracting Fira Code..."
    unzip -q "fira-code.zip"
    
    # Install fonts
    log_info "Installing Fira Code fonts..."
    find . -name "*.ttf" -exec cp {} "$fonts_dir/" \;
    
    # Cleanup
    cd - > /dev/null
    rm -rf "$temp_dir"
    
    log_success "Fira Code installed directly"
}

# Main function
main() {
    log_info "Starting font installation..."
    
    # Try Homebrew first
    if command -v brew &> /dev/null; then
        install_fonts_homebrew
    else
        log_info "Homebrew not found, installing Fira Code directly..."
        install_fira_code_direct
    fi
    
    # Refresh font cache
    log_info "Refreshing font cache..."
    fc-cache -f -v &> /dev/null || true
    
    log_success "Font installation completed!"
    log_info "You may need to restart applications to see new fonts"
}

main "$@"