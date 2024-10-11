#!/bin/bash

# Install and source Nix
curl -L https://nixos.org/nix/install | sh
. ~/.nix-profile/etc/profile.d/nix.sh

cp vimrc ~/.vimrc
cp zshrc ~/.zshrc

# Install zsh syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git 
mkdir ~/.installs
mv zsh-syntax-highlighting ~/.installs
echo "# Syntax highlighting\nsource ~/.installs/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

echo "Start nix-shell:\nnix-shell $PWD/shell.nix"