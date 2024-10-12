#!/bin/bash

# Install and source Nix
curl -L https://nixos.org/nix/install | sh
. ~/.nix-profile/etc/profile.d/nix.sh

cp vimrc ~/.vimrc
cp zshrc ~/.zshrc

# Install zsh syntax highlighting
if [ ! -d ~/.installs/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git 
    mkdir -p ~/.installs
    mv zsh-syntax-highlighting ~/.installs
fi
echo "source ~/.installs/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" > ~/.source_zsh_syntax_highlighting.sh

echo "Start nix-shell:"
echo "nix-shell $PWD/shell.nix"