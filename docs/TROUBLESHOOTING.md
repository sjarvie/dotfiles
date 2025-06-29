# 🔧 Troubleshooting Guide

Common issues and solutions for the productivity dotfiles setup.

## 🚨 Installation Issues

### Homebrew Installation Fails

**Problem**: Homebrew installation fails or is not found
```bash
brew: command not found
```

**Solutions**:
```bash
# 1. Install Xcode Command Line Tools
xcode-select --install

# 2. Manual Homebrew installation
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. Add to PATH (Apple Silicon)
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# 4. Add to PATH (Intel)
echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/usr/local/bin/brew shellenv)"

# 5. Verify installation
brew --version
```

### Permission Denied Errors

**Problem**: Permission denied when installing or linking files
```bash
Permission denied: /opt/homebrew/...
```

**Solutions**:
```bash
# Fix Homebrew permissions (Apple Silicon)
sudo chown -R $(whoami) /opt/homebrew/*

# Fix Homebrew permissions (Intel)
sudo chown -R $(whoami) /usr/local/*

# Fix home directory permissions
sudo chown -R $(whoami) ~/.config
chmod 755 ~/.config

# Fix Oh My Zsh permissions
sudo chown -R $(whoami) ~/.oh-my-zsh
chmod 755 ~/.oh-my-zsh
```

### Symlink Creation Fails

**Problem**: Cannot create symlinks for configuration files
```bash
ln: failed to create symbolic link: File exists
```

**Solutions**:
```bash
# 1. Check existing files
ls -la ~ | grep -E '\->'

# 2. Remove broken symlinks
find ~ -type l ! -exec test -e {} \; -delete

# 3. Backup existing files
mkdir ~/.dotfiles_backup
mv ~/.zshrc ~/.gitconfig ~/.dotfiles_backup/ 2>/dev/null || true

# 4. Re-run installation
make clean && make install
```

## 🐚 Shell and Terminal Issues

### Zsh Not Loading Properly

**Problem**: Zsh configuration not loading or errors on startup
```bash
zsh: command not found: git
/Users/user/.zshrc:10: command not found: brew
```

**Solutions**:
```bash
# 1. Check Zsh installation
which zsh
echo $SHELL

# 2. Set Zsh as default shell
chsh -s $(which zsh)

# 3. Source configuration manually
source ~/.zshrc

# 4. Check for syntax errors
zsh -n ~/.zshrc

# 5. Reset Oh My Zsh
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Slow Shell Startup

**Problem**: Terminal takes too long to start (>3 seconds)
```bash
# Benchmark startup time
time zsh -i -c exit
```

**Solutions**:
```bash
# 1. Profile startup time
zsh -xvs 2>&1 | ts -i "%.s" | head -20

# 2. Disable problematic plugins temporarily
# Edit ~/.zshrc and comment out plugins:
# plugins=(git z) # Minimal plugin set

# 3. Check for problematic commands
# Comment out these lines in ~/.zshrc:
# - nvm loading
# - pyenv loading
# - rbenv loading

# 4. Optimize plugin loading
# Move slow plugins to async loading
```

### Oh My Zsh Plugin Issues

**Problem**: Plugins not working or causing errors
```bash
zsh: command not found: z
[oh-my-zsh] plugin 'zsh-autosuggestions' not found
```

**Solutions**:
```bash
# 1. Reinstall plugins
rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

rm -rf ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 2. Install z plugin dependency
brew install z

# 3. Reload configuration
source ~/.zshrc
```

## 🎨 Font and Display Issues

### Fonts Not Displaying

**Problem**: Fira Code or other fonts not showing in applications
```bash
# Font not found in application font picker
```

**Solutions**:
```bash
# 1. Verify font installation
fc-list | grep -i "fira code"

# 2. Reinstall fonts
make fonts

# 3. Clear font cache
sudo atsutil databases -remove

# 4. Restart applications
killall Finder
killall SystemUIServer

# 5. Manual font installation
open ~/Library/Fonts
# Drag font files manually
```

### Terminal Colors Not Working

**Problem**: Terminal colors not displaying correctly
```bash
# Colors appear wrong or missing
```

**Solutions**:
```bash
# 1. Test terminal color support
echo -e "\033[31mRed\033[0m \033[32mGreen\033[0m \033[34mBlue\033[0m"

# 2. Check TERM variable
echo $TERM
# Should be: xterm-256color or screen-256color

# 3. Force color support
export TERM=xterm-256color

# 4. Restart terminal application

# 5. Check Ghostty configuration
cat ~/.config/ghostty/config | grep -i color
```

### Ligatures Not Working

**Problem**: Font ligatures not displaying in editor or terminal
```bash
# != doesn't show as ≠
# -> doesn't show as →
```

**Solutions**:
```bash
# 1. Verify font supports ligatures
# Check if Fira Code is properly installed

# 2. Enable ligatures in application settings
# Cursor/VS Code: "editor.fontLigatures": true
# Terminal: font-feature = +liga

# 3. Test ligatures
echo "!= == >= <= -> => =>"

# 4. Check font variant
# Use "Fira Code" not "Fira Code Regular"
```

## 🛠 Application-Specific Issues

### Cursor/VS Code Issues

**Problem**: Editor not using correct settings or theme
```bash
# Settings not applied
# Theme not loading
```

**Solutions**:
```bash
# 1. Check settings file location
ls -la "~/Library/Application Support/Cursor/User/settings.json"

# 2. Manually copy settings
cp config/cursor/settings.json "~/Library/Application Support/Cursor/User/"

# 3. Reset settings
rm "~/Library/Application Support/Cursor/User/settings.json"
# Restart Cursor and reconfigure

# 4. Check JSON syntax
jq . config/cursor/settings.json

# 5. Install missing extensions
cursor --install-extension ms-python.python
cursor --install-extension esbenp.prettier-vscode
```

### Git Configuration Issues

**Problem**: Git not using correct configuration
```bash
git config --global user.name
# Returns nothing or wrong name
```

**Solutions**:
```bash
# 1. Check git configuration
git config --global --list

# 2. Manually set user information
git config --global user.name "Your Name"
git config --global user.email "your@email.com"

# 3. Check configuration file
cat ~/.gitconfig

# 4. Re-link configuration
rm ~/.gitconfig
ln -sf ~/.dotfiles/config/git/.gitconfig ~/.gitconfig

# 5. Test Git aliases
git st  # Should run git status
```

### Ghostty Terminal Issues

**Problem**: Ghostty not starting or not using configuration
```bash
# Ghostty crashes on startup
# Configuration not loading
```

**Solutions**:
```bash
# 1. Check Ghostty installation
which ghostty
ghostty --version

# 2. Check configuration file
cat ~/.config/ghostty/config

# 3. Test with minimal config
mv ~/.config/ghostty/config ~/.config/ghostty/config.bak
echo "font-family = monospace" > ~/.config/ghostty/config

# 4. Check configuration syntax
# Remove problematic lines one by one

# 5. Reinstall Ghostty
brew uninstall --cask ghostty
brew install --cask ghostty
```

## 🔧 Development Environment Issues

### Node.js/NPM Issues

**Problem**: Node.js or npm not working correctly
```bash
node: command not found
npm: command not found
```

**Solutions**:
```bash
# 1. Check Node.js installation
which node
node --version

# 2. Install via nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.zshrc
nvm install --lts
nvm use --lts

# 3. Fix npm permissions
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc

# 4. Clear npm cache
npm cache clean --force
```

### Python/Pip Issues

**Problem**: Python or pip not working correctly
```bash
python: command not found
pip: command not found
```

**Solutions**:
```bash
# 1. Check Python installation
which python3
python3 --version

# 2. Install via pyenv
brew install pyenv
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
source ~/.zshrc
pyenv install 3.11.6
pyenv global 3.11.6

# 3. Fix pip
python3 -m ensurepip --upgrade

# 4. Create alias
echo 'alias python="python3"' >> ~/.zshrc
echo 'alias pip="pip3"' >> ~/.zshrc
```

### Docker Issues

**Problem**: Docker not working or not starting
```bash
docker: command not found
docker: Cannot connect to the Docker daemon
```

**Solutions**:
```bash
# 1. Install Docker Desktop
brew install --cask docker

# 2. Start Docker Desktop
open /Applications/Docker.app

# 3. Check Docker status
docker --version
docker info

# 4. Fix permissions
sudo groupadd docker
sudo usermod -aG docker $USER
```

## 🔍 Diagnostic Commands

### System Health Check
```bash
# Run comprehensive health check
make doctor

# Check individual components
brew doctor
git config --list
which zsh node python3

# Check file permissions
ls -la ~/.config
ls -la ~/.zshrc ~/.gitconfig
```

### Performance Diagnostics
```bash
# Shell startup time
time zsh -i -c exit

# Homebrew issues
brew doctor

# Disk space
df -h

# Memory usage
top -l 1 | head -10
```

### Configuration Validation
```bash
# Test configurations
make test

# Validate JSON files
jq . config/cursor/settings.json
jq . config/vscode/settings.json

# Check shell syntax
zsh -n ~/.zshrc
bash -n scripts/install.sh
```

## 🆘 Getting Help

### Before Reporting Issues

1. **Run diagnostics**:
   ```bash
   make doctor
   make test
   ```

2. **Check logs**:
   ```bash
   # Check system logs
   tail -f /var/log/system.log
   
   # Check Homebrew logs
   brew doctor
   ```

3. **Gather system information**:
   ```bash
   sw_vers
   uname -a
   echo $SHELL
   echo $PATH
   ```

### Reporting Issues

Include this information when reporting issues:

```bash
# System Information
echo "macOS Version: $(sw_vers -productVersion)"
echo "Architecture: $(uname -m)"
echo "Shell: $SHELL"
echo "Homebrew Version: $(brew --version | head -1)"

# Configuration Status
make doctor

# Error Output
# Include full error messages and stack traces
```

### Community Support

- **GitHub Issues**: [Project Issues](https://github.com/YOUR_USERNAME/dotfiles/issues)
- **Discussions**: [GitHub Discussions](https://github.com/YOUR_USERNAME/dotfiles/discussions)
- **Documentation**: Check `docs/` directory

### Reset Everything

If all else fails, complete reset:
```bash
# 1. Backup important data
cp -r ~/.config ~/.config_backup

# 2. Uninstall dotfiles
make uninstall

# 3. Remove Homebrew (nuclear option)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

# 4. Fresh installation
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/dotfiles/main/bootstrap.sh | bash
```

## 📚 Additional Resources

- [Homebrew Troubleshooting](https://docs.brew.sh/Troubleshooting)
- [Oh My Zsh Wiki](https://github.com/ohmyzsh/ohmyzsh/wiki)
- [Git Documentation](https://git-scm.com/doc)
- [macOS Terminal Guide](https://support.apple.com/guide/terminal/)

Remember: Most issues are solved by ensuring proper installation order and checking file permissions. When in doubt, start fresh with a clean installation.