{ pkgs, ... }: {
  imports = [
    ./git.nix
    ./ssh.nix
    ./tmux.nix
    ./zsh.nix
    ./unstable.nix
  ];
  home.packages = with pkgs; [
    jq
    htop
    wget
    tasksh
    rclone
    oh-my-posh
    taskwarrior
    timewarrior
    trackwarrior
  ];
}
