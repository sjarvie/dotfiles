# 🎯 Productivity Dotfiles

A comprehensive macOS dotfiles repository optimized for development productivity, featuring a consistent VS Code Dark theme across all tools and Apple Silicon Mac optimization.

## ✨ Features

- **🎨 Consistent Theming**: VS Code Dark theme across all tools (Ghostty, Warp, Cursor, VS Code)
- **⚡ Apple Silicon Optimized**: Fully optimized for M1/M2/M3 Macs
- **🚀 Fast Installation**: One-command setup with intelligent error handling
- **🔧 Productivity Focus**: Minimal distractions, fast tool switching, automation
- **📝 AI-Ready**: Pre-configured for Cursor and GitHub Copilot
- **🛠 Development Tools**: Python, JavaScript, TypeScript, Git workflow optimization

## 🏗 Stack Overview

| Tool | Purpose | Configuration |
|------|---------|---------------|
| **Ghostty** | Primary Terminal | VS Code Dark theme, Fira Code, optimized keybindings |
| **Warp** | Secondary Terminal | Custom VS Code Dark theme |
| **Zsh + Oh My Zsh** | Shell | Productivity aliases, functions, fast startup |
| **Cursor** | Primary Editor | AI-enhanced development, VS Code compatibility |
| **VS Code** | Secondary Editor | Consistent settings with Cursor |
| **Git** | Version Control | Enhanced aliases, conventional commits, delta diff |
| **Raycast** | Window Management | Productivity shortcuts and workflows |

## ⚡ Quick Start

### Prerequisites
- macOS Sonoma+ (Apple Silicon recommended)
- Xcode Command Line Tools

### Installation

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# One-command installation
make install

# Or run the install script directly
./install.sh
```

### What Gets Installed

**Development Tools:**
- Homebrew (Apple Silicon optimized)
- Git with enhanced configuration
- Node.js (via nvm), Python, Go, Rust
- Modern CLI tools (fd, ripgrep, bat, eza, fzf, delta)

**Applications:**
- Cursor, VS Code, Ghostty, Warp
- Raycast, 1Password, Notion, Obsidian
- Development browsers and utilities

**Fonts:**
- Fira Code (with ligatures)
- JetBrains Mono, Cascadia Code
- Nerd Fonts for terminal icons

## 📁 Repository Structure

```
dotfiles/
├── README.md                 # This file
├── Makefile                 # Management commands
├── install.sh               # Main installation script
├── bootstrap.sh             # Minimal setup script
├── config/                  # Configuration files
│   ├── ghostty/            # Ghostty terminal config
│   ├── warp/               # Warp terminal themes
│   ├── zsh/                # Zsh configuration
│   ├── git/                # Git configuration
│   ├── cursor/             # Cursor editor settings
│   ├── vscode/             # VS Code settings
│   ├── raycast/            # Raycast configurations
│   └── themes/             # Universal theme definitions
├── scripts/                # Installation scripts
│   ├── macos-setup.sh      # macOS system configuration
│   ├── install-fonts.sh    # Font installation
│   ├── install-apps.sh     # Application installation
│   ├── configure-macos.sh  # System preferences
│   └── backup.sh           # Backup utilities
├── fonts/                  # Font resources
└── docs/                   # Additional documentation
    ├── SETUP.md            # Detailed setup guide
    └── TROUBLESHOOTING.md  # Common issues and fixes
```

## 🎨 Theme Details

### VS Code Dark Color Scheme
- **Background**: `#1e1e1e`
- **Foreground**: `#d4d4d4`
- **Selection**: `#264f78`
- **Cursor**: `#aeafad`

### Font Configuration
- **Primary**: Fira Code (14px, ligatures enabled)
- **Fallbacks**: JetBrains Mono, Cascadia Code
- **Terminal**: Same font across all terminals for consistency

## 🛠 Management Commands

```bash
# Show available commands
make help

# Full installation
make install

# Update existing setup
make update

# Install fonts only
make fonts

# Install applications only
make apps

# Configure macOS settings
make macos

# System health check
make doctor

# Test configurations
make test

# Create backup
make backup

# Clean installation
make clean
```

## ⚙️ Customization

### Personal Information
Update these files with your information:
- `config/git/.gitconfig` - Name, email, GPG key
- `config/zsh/exports.zsh` - Environment variables
- `scripts/install-apps.sh` - Add/remove applications

### Theme Modifications
- `config/themes/colors.json` - Universal color definitions
- `config/ghostty/config` - Terminal colors and fonts
- `config/cursor/settings.json` - Editor theme and font

### Productivity Aliases
Edit `config/zsh/aliases.zsh` to add your own shortcuts:
```bash
alias myproject="cd ~/Projects/my-important-project"
alias deploy="npm run build && npm run deploy"
```

## 🔧 Productivity Features

### Git Workflow
- **Enhanced aliases**: `gst`, `gp`, `gpl`, `gcommit`
- **Conventional commits**: Use `gcommit feat "add new feature"`
- **Better diffs**: Delta pager with syntax highlighting
- **Branch management**: `gbr` for FZF branch switching

### Terminal Productivity
- **Smart completions**: History-based suggestions
- **Fast navigation**: `z` for directory jumping
- **Better tools**: `bat` for cat, `eza` for ls, `fd` for find
- **Project switching**: `proj` command with FZF

### Development Environment
- **Language support**: Pre-configured for Python, JavaScript, TypeScript
- **AI assistance**: Cursor with Claude integration
- **Code formatting**: Prettier, Black, ESLint configured
- **Fast startup**: Optimized shell loading (<1 second)

## 🔍 Troubleshooting

### Common Issues

**Fonts not showing**:
```bash
make fonts
# Restart applications
```

**Zsh not loading**:
```bash
source ~/.zshrc
# Check for syntax errors
make test
```

**Homebrew issues**:
```bash
make doctor
# Check system health
```

**Git configuration**:
```bash
# Set your information
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

See `docs/TROUBLESHOOTING.md` for detailed solutions.

## 📱 Application Configuration

### Ghostty Terminal
- Pre-configured with VS Code Dark theme
- Fira Code font with ligatures
- macOS-style keybindings
- Optimized for development workflow

### Cursor Editor
- AI-enhanced development experience
- Consistent with VS Code settings
- Optimized for Python, JavaScript, TypeScript
- GitHub Copilot integration

### Raycast
- Window management shortcuts
- Quick application switching
- Custom workflows for development

## 🔐 Security & Privacy

- **Telemetry disabled** in VS Code and extensions
- **Minimal data collection** settings
- **GPG signing** support for Git commits
- **1Password integration** for secure credential management

## 🆘 Support

- **Issues**: [GitHub Issues](https://github.com/YOUR_USERNAME/dotfiles/issues)
- **Discussions**: [GitHub Discussions](https://github.com/YOUR_USERNAME/dotfiles/discussions)
- **Documentation**: `docs/` directory

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

## 🙏 Acknowledgments

- [Oh My Zsh](https://ohmyz.sh/) community
- [Homebrew](https://brew.sh/) maintainers
- [VS Code](https://code.visualstudio.com/) team
- [Fira Code](https://github.com/tonsky/FiraCode) font creators

---

**⭐ Star this repo if it helped boost your productivity!**
