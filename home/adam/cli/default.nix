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
    rclone
    tailscale
    oh-my-posh
  ];
}
