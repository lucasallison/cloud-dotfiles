#!/bin/bash

if ! command -v nix &> /dev/null; then
    echo "* Installing Nix..."
    curl -L https://nixos.org/nix/install | sh
    . ~/.nix-profile/etc/profile.d/nix.sh
fi

echo "* Setting vim and zsh configurations..."

# Set vimrc
cp default.vimrc ~/.vimrc

# Set a default zshrc
cp default.zshrc ~/.zshrc.default

# Install zsh syntax highlighting
if [ ! -d ~/.installs/zsh-syntax-highlighting ]; then
    echo "* Installing zsh syntax highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git 
    mkdir -p ~/.installs
    mv zsh-syntax-highlighting ~/.installs
fi

# Add sourcing zsh syntax highlighting to default zshrc
echo "" >> ~/.zshrc.default
echo "# Zsh syntax highlighting" >> ~/.zshrc.default
echo "source ~/.installs/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc.default
echo "" >> ~/.zshrc.default

# Source the default zshrc 
if [ ! -f ~/.zshrc ] || ! grep -Fxq ". ~/.zshrc.default" ~/.zshrc; then
    echo "# Source default zshrc" >> ~/.zshrc
    echo ". ~/.zshrc.default" >> ~/.zshrc
fi

# Add script to open nix-shell
echo "nix-shell $PWD/shell.nix" > ~/.open_default_nix_shell.sh

echo "* Everything is configured!"
nix-shell $PWD/shell.nix