# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew install homebrew/dupes/grep

echo '$PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH' >> ~/.bash_profile

binaries=(
  graphicsmagick
  webkit2png
  rename
  zopfli
  ffmpeg
  python
  sshfs
  trash
  node
  tree
  ack
  hub
  git
)

echo "installing binaries..."
brew install ${binaries[@]}

brew cleanup


# install cask
brew install caskroom/cask/brew-cask


brew cask search /google-chrome/

# Apps
apps=(
  alfred
  google-chrome
  qlcolorcode
  screenflick
  transmit
  appcleaner
  firefox
  qlmarkdown
  seil
  spotify
  vagrant
  iterm2
  atom
  flux
  vlc
  quicklook-json
)


# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

brew tap caskroom/versions


brew tap caskroom/fonts

# fonts
fonts=(
  font-m-plus
  font-clear-sans
  font-anonymous-pro
)

# install fonts
echo "installing fonts..."
brew cask install ${fonts[@]}

# TODO Mackup

# osx-for-hackers.shA
#chmod +x ./dot-osx-for-hackers.sh
#./dot-osx-for-hackers.sh



# AutoJump
brew install autojump


# Hush Login
touch ~/.hushlogin
