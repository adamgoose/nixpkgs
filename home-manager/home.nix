{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./apps
  ];

  # Comment out if you wish to disable unfree packages for your system
  # nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    htop
    pass
    rclone
    lazygit
    ripgrep
    tailscale
    oh-my-posh

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

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
