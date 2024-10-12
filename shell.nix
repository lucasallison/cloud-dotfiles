{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    vim
    fzf
    fd
    zsh
    autojump
    ripgrep
    tmux
  ];

  shellHook = ''
    echo "source ${pkgs.autojump}/etc/profile.d/autojump.sh" > ~/.source_autojump.sh
    export SHELL=${pkgs.zsh}/bin/zsh
    exec ${pkgs.zsh}/bin/zsh
  '';
}
