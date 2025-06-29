#!/bin/bash

# Dotfiles Installation Script
# Optimized for Apple Silicon Macs and productivity workflow

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        log_error "This script is designed for macOS only."
        exit 1
    fi
}

# Check if running on Apple Silicon
check_apple_silicon() {
    if [[ $(uname -m) == "arm64" ]]; then
        log_info "Detected Apple Silicon Mac"
        export HOMEBREW_PREFIX="/opt/homebrew"
        export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
        export HOMEBREW_REPOSITORY="/opt/homebrew"
    else
        log_info "Detected Intel Mac"
        export HOMEBREW_PREFIX="/usr/local"
        export HOMEBREW_CELLAR="/usr/local/Cellar"
        export HOMEBREW_REPOSITORY="/usr/local/Homebrew"
    fi
}

# Create backup of existing dotfiles
backup_existing() {
    log_info "Backing up existing dotfiles..."
    
    local backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    
    # List of files to backup
    local files=(
        ".zshrc"
        ".zprofile"
        ".gitconfig"
        ".gitignore_global"
        ".gitmessage"
    )
    
    for file in "${files[@]}"; do
        if [[ -f "$HOME/$file" ]]; then
            mv "$HOME/$file" "$backup_dir/"
            log_warning "Backed up $file to $backup_dir"
        fi
    done
    
    # Backup existing configs
    local config_dirs=(
        ".config/ghostty"
        ".config/git"
        ".config/zsh"
        "Library/Application Support/Cursor/User"
        "Library/Application Support/Code/User"
    )
    
    for dir in "${config_dirs[@]}"; do
        if [[ -d "$HOME/$dir" ]]; then
            mkdir -p "$backup_dir/$(dirname "$dir")"
            cp -r "$HOME/$dir" "$backup_dir/$dir"
            log_warning "Backed up $dir to $backup_dir"
        fi
    done
    
    log_success "Backup completed at $backup_dir"
}

# Install Homebrew if not present
install_homebrew() {
    if ! command -v brew &> /dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/usr/local/bin/brew shellenv)"
        fi
        
        log_success "Homebrew installed successfully"
    else
        log_info "Homebrew already installed, updating..."
        brew update
        log_success "Homebrew updated"
    fi
}

# Create symlinks for configuration files
create_symlinks() {
    log_info "Creating symlinks..."
    
    local dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Ensure config directories exist
    mkdir -p "$HOME/.config"
    
    # Symlink configurations
    local symlinks=(
        "$dotfiles_dir/config/zsh/.zshrc:$HOME/.zshrc"
        "$dotfiles_dir/config/zsh/.zprofile:$HOME/.zprofile"
        "$dotfiles_dir/config/git/.gitconfig:$HOME/.gitconfig"
        "$dotfiles_dir/config/git/.gitignore_global:$HOME/.gitignore_global"
        "$dotfiles_dir/config/git/.gitmessage:$HOME/.gitmessage"
        "$dotfiles_dir/config:$HOME/.config/dotfiles"
    )
    
    for link in "${symlinks[@]}"; do
        local source="${link%:*}"
        local target="${link#*:}"
        
        # Remove existing file/link
        if [[ -L "$target" ]]; then
            rm "$target"
        elif [[ -f "$target" ]]; then
            log_warning "File $target already exists, skipping..."
            continue
        fi
        
        # Create directory if needed
        mkdir -p "$(dirname "$target")"
        
        # Create symlink
        ln -sf "$source" "$target"
        log_success "Linked $source -> $target"
    done
    
    # Special handling for application configs
    local app_configs=(
        "$dotfiles_dir/config/ghostty:$HOME/.config/ghostty"
        "$dotfiles_dir/config/git:$HOME/.config/git"
        "$dotfiles_dir/config/zsh:$HOME/.config/zsh"
        "$dotfiles_dir/config/themes:$HOME/.config/themes"
    )
    
    for config in "${app_configs[@]}"; do
        local source="${config%:*}"
        local target="${config#*:}"
        
        if [[ -L "$target" ]]; then
            rm "$target"
        elif [[ -d "$target" ]]; then
            log_warning "Directory $target already exists, skipping..."
            continue
        fi
        
        mkdir -p "$(dirname "$target")"
        ln -sf "$source" "$target"
        log_success "Linked $source -> $target"
    done
}

# Setup Git configuration
setup_git() {
    log_info "Setting up Git configuration..."
    
    # Prompt for user details if not already set
    if ! git config --global user.name &> /dev/null; then
        read -p "Enter your Git name: " git_name
        git config --global user.name "$git_name"
    fi
    
    if ! git config --global user.email &> /dev/null; then
        read -p "Enter your Git email: " git_email
        git config --global user.email "$git_email"
    fi
    
    # Update gitconfig file with actual values
    local gitconfig="$HOME/.gitconfig"
    sed -i.bak "s/YOUR_NAME/$(git config --global user.name)/g" "$gitconfig"
    sed -i.bak "s/YOUR_EMAIL/$(git config --global user.email)/g" "$gitconfig"
    rm "$gitconfig.bak"
    
    log_success "Git configuration completed"
}

# Install Oh My Zsh and plugins
setup_zsh() {
    log_info "Setting up Zsh and Oh My Zsh..."
    
    # Install Oh My Zsh if not present
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        log_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        log_success "Oh My Zsh installed"
    fi
    
    # Install Powerlevel10k theme
    local p10k_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    if [[ ! -d "$p10k_dir" ]]; then
        log_info "Installing Powerlevel10k theme..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
        log_success "Powerlevel10k installed"
    fi
    
    # Install Zsh plugins
    local plugins_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
    
    # zsh-autosuggestions
    if [[ ! -d "$plugins_dir/zsh-autosuggestions" ]]; then
        log_info "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$plugins_dir/zsh-autosuggestions"
        log_success "zsh-autosuggestions installed"
    fi
    
    # zsh-syntax-highlighting
    if [[ ! -d "$plugins_dir/zsh-syntax-highlighting" ]]; then
        log_info "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$plugins_dir/zsh-syntax-highlighting"
        log_success "zsh-syntax-highlighting installed"
    fi
    
    log_success "Zsh setup completed"
}

# Run sub-scripts
run_subscripts() {
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/scripts"
    
    # Make scripts executable
    chmod +x "$script_dir"/*.sh
    
    # Run font installation
    log_info "Installing fonts..."
    "$script_dir/install-fonts.sh"
    
    # Run app installation
    log_info "Installing applications..."
    "$script_dir/install-apps.sh"
    
    # Run macOS configuration
    log_info "Configuring macOS settings..."
    "$script_dir/configure-macos.sh"
}

# Main installation function
main() {
    log_info "Starting dotfiles installation..."
    log_info "Optimized for Apple Silicon Macs and productivity workflow"
    
    check_macos
    check_apple_silicon
    backup_existing
    install_homebrew
    create_symlinks
    setup_git
    setup_zsh
    run_subscripts
    
    log_success "Dotfiles installation completed!"
    log_info "Please restart your terminal or run 'source ~/.zshrc' to apply changes"
    log_info "Run 'p10k configure' to set up your prompt"
}

# Run main function
main "$@"