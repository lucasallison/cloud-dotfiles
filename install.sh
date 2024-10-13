#!/bin/bash

if ! command -v nix &> /dev/null; then
    echo "* Installing Nix..."
    curl -L https://nixos.org/nix/install | sh
    . ~/.nix-profile/etc/profile.d/nix.sh
fi

if [ ! -d "~/.config/nix_shell" ]; then
    mkdir -p ~/.config/nix_shell
fi

echo "* Setting vim and zsh configurations..."
cp default.vimrc ~/.vimrc
cp default.zshrc ~/.config/nix_shell/.default.zshrc

if [ ! -f ~/.zshrc ] || ! grep -Fxq ". ~/.config/.default.zshrc" ~/.zshrc; then
    echo ". ~/.config/.default.zshrc" >> ~/.zshrc
fi

echo "nix-shell $PWD/shell.nix" > ~/.config/nix_shell/.open_default_nix_shell.sh

# Install zsh syntax highlighting
if [ ! -d ~/.installs/zsh-syntax-highlighting ]; then
    echo "* Installing zsh syntax highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git 
    mkdir -p ~/.installs
    mv zsh-syntax-highlighting ~/.installs
fi

echo "source ~/.installs/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" > ~/.config/nix_shell/.source_zsh_syntax_highlighting.sh

echo "* Everything is configured!"
nix-shell $PWD/shell.nix