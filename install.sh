#!/bin/bash

if ! command -v nix &> /dev/null; then
    echo "* Installing Nix..."
    curl -L https://nixos.org/nix/install | sh
    . ~/.nix-profile/etc/profile.d/nix.sh
fi

echo "* Setting vim and zsh configurations..."
cp vimrc ~/.vimrc
cp zshrc ~/.zshrc
echo "nix-shell $PWD/shell.nix" > ~/.config/.open_default_nix_shell.sh

# Install zsh syntax highlighting
if [ ! -d ~/.installs/zsh-syntax-highlighting ]; then
    echo "* Installing zsh syntax highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git 
    mkdir -p ~/.installs
    mv zsh-syntax-highlighting ~/.installs
fi

if [ ! -d "~/.config" ]; then
    mkdir -p ~/.config
fi
echo "source ~/.installs/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" > ~/.config/.source_zsh_syntax_highlighting.sh

echo "* Everything is configured!"
nix-shell $PWD/shell.nix