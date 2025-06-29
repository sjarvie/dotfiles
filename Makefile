# Dotfiles Makefile
# Productivity stack management for macOS

.PHONY: help install update backup clean fonts apps macos test doctor

# Default target
.DEFAULT_GOAL := help

# Colors for output
BLUE = \033[0;34m
GREEN = \033[0;32m
YELLOW = \033[1;33m
RED = \033[0;31m
NC = \033[0m # No Color

# Helper function to print colored output
define log_info
	@echo "$(BLUE)[INFO]$(NC) $(1)"
endef

define log_success
	@echo "$(GREEN)[SUCCESS]$(NC) $(1)"
endef

define log_warning
	@echo "$(YELLOW)[WARNING]$(NC) $(1)"
endef

define log_error
	@echo "$(RED)[ERROR]$(NC) $(1)"
endef

## Show this help message
help:
	@echo "$(BLUE)Dotfiles Management$(NC)"
	@echo "===================="
	@echo ""
	@echo "$(GREEN)Available targets:$(NC)"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  $(YELLOW)%-15s$(NC) %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ""
	@echo "$(GREEN)Quick start:$(NC)"
	@echo "  make install    # Full installation"
	@echo "  make doctor     # Check system health"
	@echo "  make update     # Update existing setup"

## Full installation of dotfiles and applications
install:
	$(call log_info,"Starting full dotfiles installation...")
	@chmod +x install.sh
	@./install.sh
	$(call log_success,"Installation completed!")

## Update existing dotfiles configuration
update:
	$(call log_info,"Updating dotfiles...")
	@git pull origin main || git pull origin master
	@chmod +x scripts/*.sh
	@./scripts/install-fonts.sh
	@source ~/.zshrc || true
	$(call log_success,"Update completed!")

## Create backup of current configurations
backup:
	$(call log_info,"Creating backup of current configurations...")
	@mkdir -p ~/.dotfiles_backup_$$(date +%Y%m%d_%H%M%S)
	@cp -r ~/.config ~/.dotfiles_backup_$$(date +%Y%m%d_%H%M%S)/ 2>/dev/null || true
	@cp ~/.zshrc ~/.dotfiles_backup_$$(date +%Y%m%d_%H%M%S)/ 2>/dev/null || true
	@cp ~/.gitconfig ~/.dotfiles_backup_$$(date +%Y%m%d_%H%M%S)/ 2>/dev/null || true
	$(call log_success,"Backup created in ~/.dotfiles_backup_*")

## Remove symlinks and restore original files
clean:
	$(call log_warning,"Removing dotfiles symlinks...")
	@rm -f ~/.zshrc ~/.zprofile ~/.gitconfig ~/.gitignore_global ~/.gitmessage
	@rm -rf ~/.config/ghostty ~/.config/git ~/.config/zsh ~/.config/themes
	@rm -rf ~/.config/dotfiles
	$(call log_success,"Symlinks removed")

## Install fonts only
fonts:
	$(call log_info,"Installing fonts...")
	@chmod +x scripts/install-fonts.sh
	@./scripts/install-fonts.sh
	$(call log_success,"Fonts installation completed!")

## Install applications only
apps:
	$(call log_info,"Installing applications...")
	@chmod +x scripts/install-apps.sh
	@./scripts/install-apps.sh
	$(call log_success,"Applications installation completed!")

## Configure macOS settings
macos:
	$(call log_info,"Configuring macOS settings...")
	@chmod +x scripts/configure-macos.sh
	@./scripts/configure-macos.sh
	$(call log_success,"macOS configuration completed!")

## Run system health checks
doctor:
	$(call log_info,"Running system health checks...")
	@echo ""
	@echo "$(GREEN)System Information:$(NC)"
	@echo "  OS: $$(sw_vers -productName) $$(sw_vers -productVersion)"
	@echo "  Architecture: $$(uname -m)"
	@echo ""
	@echo "$(GREEN)Tool Status:$(NC)"
	@command -v brew >/dev/null 2>&1 && echo "  ✅ Homebrew installed" || echo "  ❌ Homebrew missing"
	@command -v git >/dev/null 2>&1 && echo "  ✅ Git installed" || echo "  ❌ Git missing"
	@command -v zsh >/dev/null 2>&1 && echo "  ✅ Zsh installed" || echo "  ❌ Zsh missing"
	@command -v cursor >/dev/null 2>&1 && echo "  ✅ Cursor installed" || echo "  ❌ Cursor missing"
	@command -v ghostty >/dev/null 2>&1 && echo "  ✅ Ghostty installed" || echo "  ❌ Ghostty missing"
	@command -v node >/dev/null 2>&1 && echo "  ✅ Node.js installed" || echo "  ❌ Node.js missing"
	@command -v python3 >/dev/null 2>&1 && echo "  ✅ Python3 installed" || echo "  ❌ Python3 missing"
	@echo ""
	@echo "$(GREEN)Configuration Status:$(NC)"
	@test -f ~/.zshrc && echo "  ✅ Zsh config linked" || echo "  ❌ Zsh config missing"
	@test -f ~/.gitconfig && echo "  ✅ Git config linked" || echo "  ❌ Git config missing"
	@test -d ~/.config/ghostty && echo "  ✅ Ghostty config linked" || echo "  ❌ Ghostty config missing"
	@test -d ~/.oh-my-zsh && echo "  ✅ Oh My Zsh installed" || echo "  ❌ Oh My Zsh missing"
	@echo ""
	@echo "$(GREEN)Font Status:$(NC)"
	@fc-list | grep -i "fira code" >/dev/null 2>&1 && echo "  ✅ Fira Code installed" || echo "  ❌ Fira Code missing"
	@echo ""
	$(call log_success,"Health check completed!")

## Test configurations
test:
	$(call log_info,"Testing configurations...")
	@echo "$(GREEN)Testing Zsh configuration...$(NC)"
	@zsh -n config/zsh/.zshrc && echo "  ✅ Zsh config syntax OK" || echo "  ❌ Zsh config syntax error"
	@echo "$(GREEN)Testing Git configuration...$(NC)"
	@git config --file config/git/.gitconfig --list >/dev/null 2>&1 && echo "  ✅ Git config OK" || echo "  ❌ Git config error"
	@echo "$(GREEN)Testing JSON configurations...$(NC)"
	@command -v jq >/dev/null 2>&1 && jq . config/cursor/settings.json >/dev/null 2>&1 && echo "  ✅ Cursor settings JSON OK" || echo "  ❌ Cursor settings JSON error"
	@command -v jq >/dev/null 2>&1 && jq . config/vscode/settings.json >/dev/null 2>&1 && echo "  ✅ VS Code settings JSON OK" || echo "  ❌ VS Code settings JSON error"
	$(call log_success,"Configuration tests completed!")

## Quick setup for development environment only
dev:
	$(call log_info,"Setting up development environment...")
	@make fonts
	@chmod +x scripts/install-apps.sh
	@./scripts/install-apps.sh
	@make update
	$(call log_success,"Development environment ready!")

## Bootstrap on a new machine (minimal setup)
bootstrap:
	$(call log_info,"Bootstrapping new machine...")
	@command -v brew >/dev/null 2>&1 || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@brew install git curl
	@make install
	$(call log_success,"Bootstrap completed!")

## Show current configuration status
status:
	$(call log_info,"Current configuration status...")
	@echo ""
	@echo "$(GREEN)Symlinks:$(NC)"
	@ls -la ~ | grep -E '\->' | grep -E '(zsh|git)' || echo "  No dotfiles symlinks found"
	@echo ""
	@echo "$(GREEN)Config directories:$(NC)"
	@ls -la ~/.config | grep -E '\->' || echo "  No config symlinks found"
	@echo ""
	@echo "$(GREEN)Git configuration:$(NC)"
	@git config --global user.name 2>/dev/null && echo "  Name: $$(git config --global user.name)" || echo "  Name: Not set"
	@git config --global user.email 2>/dev/null && echo "  Email: $$(git config --global user.email)" || echo "  Email: Not set"
	@echo ""

## Uninstall everything and clean up
uninstall:
	$(call log_warning,"This will remove all dotfiles and configurations!")
	@read -p "Are you sure? (y/N): " confirm && [ "$$confirm" = "y" ] || exit 1
	@make clean
	@rm -rf ~/.oh-my-zsh
	@brew uninstall --cask ghostty cursor warp || true
	$(call log_success,"Uninstall completed!")

## Update Homebrew and all packages
brew-update:
	$(call log_info,"Updating Homebrew and packages...")
	@brew update
	@brew upgrade
	@brew cleanup
	@brew doctor
	$(call log_success,"Homebrew update completed!")

## Show dotfiles repository information
info:
	@echo "$(BLUE)Dotfiles Repository Information$(NC)"
	@echo "================================"
	@echo "Path: $$(pwd)"
	@echo "Git remote: $$(git remote get-url origin 2>/dev/null || echo 'Not a git repository')"
	@echo "Git branch: $$(git branch --show-current 2>/dev/null || echo 'Not a git repository')"
	@echo "Last commit: $$(git log -1 --oneline 2>/dev/null || echo 'No commits found')"
	@echo ""
	@echo "$(GREEN)Configuration files:$(NC)"
	@find config -type f | head -10
	@echo ""