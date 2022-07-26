{ pkgs, ... }: {
  imports = [
    ./git.nix
    ./neovim.nix
    ./ssh.nix
    ./tmux.nix
    ./zsh.nix
  ];
  home.packages = with pkgs; [
    htop
    pass
    rclone
    lazygit
    ripgrep
    tailscale
    oh-my-posh
    tere

    aws-vault
    nodejs
    go_1_18
    rnix-lsp
    postgresql

    k9s
    tilt
    kube3d
    awscli2
    teleport
    tfswitch
    pulumi-bin
    terragrunt
    kubectx
    truss-cli
    # TODO: truss-local
  ];
}
