{ pkgs, ... }: {
  imports = [
    ./git.nix
    ./neovim.nix
    ./ssh.nix
    ./tmux.nix
    ./zsh.nix
  ];
  home.packages = with pkgs; [
    jq
    htop
    pass
    rclone
    lazygit
    ripgrep
    tailscale
    oh-my-posh
    tere
    vault

    aws-vault
    nodejs
    go_1_18
    rnix-lsp
    postgresql

    k9s
    kubernetes-helm
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
    # truss-local

    kotlin-language-server
  ];
}
