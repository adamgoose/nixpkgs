# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors), use something like:
    # inputs.nix-colors.homeManagerModule

    # Feel free to split up your configuration and import pieces of it here.
    ./apps
  ];

  # Comment out if you wish to disable unfree packages for your system
  # nixpkgs.config.allowUnfree = true;

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
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
  ];

  # home.shellAliases = (pkgs.callPackage ./apps/zsh {}).home.shellAliases;
  # home.sessionVariables = (pkgs.callPackage ./apps/zsh {}).home.sessionVariables;

  # Enable home-manager and git
  programs.home-manager.enable = true;
  # programs.git.enable = true;
  # programs.ssh = (pkgs.callPackage ./apps/ssh {}).programs.ssh;
  # programs.zsh = (pkgs.callPackage ./apps/zsh {}).programs.zsh;
  # programs.tmux = (pkgs.callPackage ./apps/tmux {}).programs.tmux;
  # programs.neovim = (pkgs.callPackage ./apps/neovim {}).programs.neovim;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;


  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
