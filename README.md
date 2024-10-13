# Simple Shell Environment

This directory contains Nix shell configurations to quickly set up and manage a simple shell environment.

## `install.sh`

This script installs Nix and configures the shell environment. Specifically:

- Copies the `default.vimrc` file to `~/.vimrc` to set up Vim with default settings.
- Copies any Zsh configuration files to `~/.config/nix_shell`.
- Appends a line to the `~/.zshrc` to source the copied `default.zshrc`, ensuring that the default Zsh configuration is loaded separately from any existing custom configurations. This keeps any settings in `~/.zshrc` isolated from the default environment, preventing conflicts.

