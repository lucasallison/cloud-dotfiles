#!/bin/bash


if ! command -v nix &> /dev/null; then
    echo "* Installing Nix..."
    curl -L https://nixos.org/nix/install | sh
    . ~/.nix-profile/etc/profile.d/nix.sh
fi

NIX_SHELL_CONFIG_DIR=~/.config/nix_shell

if [ ! -d $NIX_SHELL_CONFIG_DIR ]; then
    mkdir -p $NIX_SHELL_CONFIG_DIR
fi

echo "* Setting vim and zsh configurations..."
cp default.vimrc ~/.vimrc
cp default.zshrc $NIX_SHELL_CONFIG_DIR/.default.zshrc

if [ ! -f ~/.zshrc ] || ! grep -Fxq ". $NIX_SHELL_CONFIG_DIR/.default.zshrc" ~/.zshrc; then
    echo ". $NIX_SHELL_CONFIG_DIR/.default.zshrc" >> ~/.zshrc
fi

echo "nix-shell $PWD/shell.nix" > $NIX_SHELL_CONFIG_DIR/.open_default_nix_shell.sh

# Install zsh syntax highlighting
if [ ! -d ~/.installs/zsh-syntax-highlighting ]; then
    echo "* Installing zsh syntax highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git 
    mv zsh-syntax-highlighting $NIX_SHELL_CONFIG_DIR
fi

echo "source $NIX_SHELL_CONFIG_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" > $NIX_SHELL_CONFIG_DIR/.source_zsh_syntax_highlighting.sh

echo "* Everything is configured!"
nix-shell $PWD/shell.nix