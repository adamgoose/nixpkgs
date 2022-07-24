{ pkgs, ... }: {
  imports = [
    ./git
    ./neovim
    ./ssh
    ./tmux
    ./zsh
  ];
}
