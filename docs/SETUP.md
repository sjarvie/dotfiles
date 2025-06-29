# 🛠 Detailed Setup Guide

This guide provides step-by-step instructions for setting up your productivity dotfiles on macOS.

## 🎯 Prerequisites

### System Requirements
- **macOS**: Sonoma 14.0+ (recommended for Apple Silicon optimization)
- **Hardware**: Apple Silicon Mac (M1/M2/M3) for best performance
- **Storage**: At least 5GB free space for applications
- **Internet**: Stable connection for downloads

### Pre-Installation Checklist
- [ ] Backup existing configurations
- [ ] Sign in to App Store (for some applications)
- [ ] Have admin password ready
- [ ] Close unnecessary applications

## 📥 Installation Methods

### Method 1: Quick Install (Recommended)
```bash
# Clone and install in one command
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/dotfiles/main/bootstrap.sh | bash
```

### Method 2: Manual Install
```bash
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# 2. Make scripts executable
chmod +x install.sh scripts/*.sh

# 3. Run installation
./install.sh
```

### Method 3: Step-by-Step Install
```bash
# Clone repository
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Install individual components
make fonts        # Install fonts first
make apps         # Install applications
make macos        # Configure macOS settings
make install      # Link configurations
```

## ⚙️ Configuration Steps

### 1. Personal Information Setup

#### Git Configuration
Edit your personal information:
```bash
# Open git config
cursor config/git/.gitconfig

# Update these fields:
# [user]
#   name = Your Full Name
#   email = your.email@example.com
#   signingkey = YOUR_GPG_KEY_ID (optional)
```

#### Zsh Environment
```bash
# Edit environment variables
cursor config/zsh/exports.zsh

# Common customizations:
export EDITOR="cursor"                    # Your preferred editor
export PROJECTS_DIR="$HOME/Projects"     # Your projects directory
export WORK_DIR="$HOME/Work"             # Work projects directory
```

### 2. Application-Specific Setup

#### Ghostty Terminal
The configuration is automatically linked. To verify:
```bash
# Check Ghostty config
cat ~/.config/ghostty/config

# Test terminal colors
echo -e "\033[31mRed\033[0m \033[32mGreen\033[0m \033[34mBlue\033[0m"
```

#### Cursor Editor
1. **Install Cursor** (done automatically)
2. **Sign in** to Cursor account for AI features
3. **Install extensions** (recommended):
   ```bash
   # Extensions are configured in settings.json
   # These will be suggested on first launch:
   # - Python extension pack
   # - ES7+ React/Redux/React-Native snippets
   # - Prettier
   # - ESLint
   # - GitLens
   ```

#### Raycast Setup
1. **Launch Raycast** after installation
2. **Import configurations**:
   ```bash
   # Copy Raycast settings (manual step)
   open config/raycast/
   # Import the .rayconfig file through Raycast settings
   ```
3. **Set up hotkeys**:
   - Main trigger: `⌘ + Space`
   - Window management: `⌘ + ⌥ + Arrow keys`

### 3. Development Environment

#### Node.js Setup
```bash
# Install Node.js via nvm (done automatically)
nvm install --lts
nvm use --lts
nvm alias default lts/*

# Verify installation
node --version
npm --version
```

#### Python Setup
```bash
# Install Python via pyenv (done automatically)
pyenv install 3.11.6
pyenv global 3.11.6

# Verify installation
python --version
pip --version
```

#### Additional Languages
```bash
# Go
go version

# Rust
rustc --version
cargo --version
```

### 4. Terminal Enhancement

#### Oh My Zsh Plugins
The following plugins are pre-configured:
- `git` - Git aliases and functions
- `z` - Directory jumping
- `zsh-autosuggestions` - Command suggestions
- `zsh-syntax-highlighting` - Syntax highlighting
- `docker` - Docker completions
- `brew` - Homebrew completions

#### Powerlevel10k Theme
```bash
# Configure prompt (run after installation)
p10k configure

# Recommended settings:
# - Lean style
# - Unicode characters
# - 24-hour time
# - Angled separators
# - Sharp prompt heads
# - Flat prompt tails
# - 2-line prompt
# - Dotted connection
# - Left frame
# - Sparse prompt spacing
# - Many icons
# - Concise prompt flow
```

### 5. Font Configuration

#### System Font Setup
Fonts are installed automatically, but verify:
```bash
# Check installed fonts
fc-list | grep -i "fira code"

# Should show multiple Fira Code variants
```

#### Application Font Settings
All applications are pre-configured with Fira Code, but verify:

**Terminal apps**: Automatically configured
**Cursor/VS Code**: Check settings for `"editor.fontFamily": "Fira Code"`
**System**: Consider setting Fira Code as default monospace font

## 🎨 Theme Customization

### Color Scheme Modification
```bash
# Edit universal colors
cursor config/themes/colors.json

# Update specific app themes
cursor config/ghostty/config          # Terminal colors
cursor config/cursor/settings.json    # Editor theme
```

### Custom Theme Creation
```bash
# Create new theme based on VS Code Dark
cp config/themes/vscode-dark.conf config/themes/my-theme.conf

# Edit colors to your preference
cursor config/themes/my-theme.conf

# Update application configs to use new theme
```

## 🔧 Advanced Configuration

### Custom Aliases and Functions
```bash
# Add personal aliases
echo 'alias myalias="your command here"' >> config/zsh/aliases.zsh

# Add custom functions
cursor config/zsh/functions.zsh
```

### Git Workflow Customization
```bash
# Add custom Git aliases
cursor config/git/.gitconfig

# Example additions:
# [alias]
#   pushup = "!git push --set-upstream origin $(git branch --show-current)"
#   cleanup = "!git branch --merged | grep -v '\\*\\|master\\|main' | xargs -n 1 git branch -d"
```

### macOS System Preferences
```bash
# Customize macOS settings
cursor scripts/configure-macos.sh

# Add your preferred settings to the script
```

## 🔍 Verification Steps

### 1. Basic Functionality
```bash
# Test shell functionality
which zsh
echo $ZSH_VERSION

# Test aliases
gst  # Should run git status
ll   # Should run ls -la with colors
```

### 2. Application Configuration
```bash
# Run system check
make doctor

# Test individual components
make test
```

### 3. Development Environment
```bash
# Test development tools
node --version
python --version
git --version
code --version  # or cursor --version

# Test package managers
npm --version
pip --version
brew --version
```

## 🚨 Troubleshooting Setup

### Common Setup Issues

#### Homebrew Installation Fails
```bash
# Check Xcode Command Line Tools
xcode-select --install

# Manually install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add to PATH (Apple Silicon)
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

#### Oh My Zsh Installation Issues
```bash
# Manual Oh My Zsh installation
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Fix permissions
chmod 755 ~/.oh-my-zsh
```

#### Font Issues
```bash
# Clear font cache
sudo atsutil databases -remove

# Reinstall fonts
make fonts

# Restart applications
```

#### Symlink Issues
```bash
# Check existing symlinks
ls -la ~ | grep -E '\->'

# Remove broken symlinks
find ~ -type l ! -exec test -e {} \; -delete

# Re-create symlinks
make clean && make install
```

### Permission Issues
```bash
# Fix common permission issues
sudo chown -R $(whoami) /opt/homebrew/*
sudo chown -R $(whoami) ~/.oh-my-zsh
chmod 755 ~/.config
```

## 📱 Application-Specific Setup

### Cursor Specific
1. **Sign in to Cursor account**
2. **Enable AI features**
3. **Install recommended extensions**
4. **Configure workspace settings**

### Raycast Specific
1. **Set as default launcher** (replace Spotlight)
2. **Import custom commands**
3. **Configure clipboard history**
4. **Set up calculator preferences**

### 1Password Integration
```bash
# Install 1Password CLI (if using)
brew install 1password-cli

# Configure SSH agent integration
# Follow 1Password SSH setup guide
```

## 🔄 Post-Installation

### Daily Workflow
1. **Open Ghostty** as primary terminal
2. **Use Raycast** for application switching
3. **Develop in Cursor** with AI assistance
4. **Manage tasks** in preferred app (Todoist/Notion)

### Regular Maintenance
```bash
# Weekly updates
make update

# Monthly cleanup
make brew-update
brew cleanup
brew doctor

# Check system health
make doctor
```

### Backup Strategy
```bash
# Create backup before major changes
make backup

# Regular git commits of custom changes
cd ~/.dotfiles
git add .
git commit -m "feat: update personal configurations"
git push
```

## 🎯 Next Steps

After successful installation:

1. **Customize** aliases and functions for your workflow
2. **Install** additional development tools as needed
3. **Configure** project-specific settings
4. **Set up** automated backups
5. **Share** improvements back to the community

For ongoing support, see [TROUBLESHOOTING.md](TROUBLESHOOTING.md) or create an issue on GitHub.