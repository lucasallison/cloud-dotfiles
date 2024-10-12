#!/bin/bash

echo "Installing Nix..."
if ! command -v nix &> /dev/null; then
    curl -L https://nixos.org/nix/install | sh
fi
. ~/.nix-profile/etc/profile.d/nix.sh

echo "Setting vim and zsh configurations..."
cp vimrc ~/.vimrc
cp zshrc ~/.zshrc

echo "Installing zsh syntax highlighting..."
# Install zsh syntax highlighting
if [ ! -d ~/.installs/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git 
    mkdir -p ~/.installs
    mv zsh-syntax-highlighting ~/.installs
fi
echo "source ~/.installs/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" > ~/.source_zsh_syntax_highlighting.sh

echo "Everything should be configured! Start the nix-shell with:"
echo "nix-shell $PWD/shell.nix"