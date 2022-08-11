{ inputs, lib, username, homeDirectory, features, ... }:

let
  inherit (builtins) map pathExists filter;
in
{
  # Import features that have modules
  imports = filter pathExists (map (feature: ./${feature}) features);

  nixpkgs.config.allowUnfree = true;
  systemd.user.startServices = "sd-switch";
  programs.home-manager.enable = true;
  programs.git.enable = true;

  home = {
    inherit username homeDirectory;
    stateVersion = "22.05";
  };

  # home.packages = with pkgs; [
  #   htop
  #   pass
  #   rclone
  #   lazygit
  #   ripgrep
  #   tailscale
  #   oh-my-posh

  #   aws-vault
  #   nodejs
  #   go_1_18
  #   rnix-lsp
  #   postgresql

  #   k9s
  #   tilt
  #   kube3d
  #   awscli2
  #   teleport
  #   tfswitch
  #   pulumi-bin
  #   terragrunt
  #   kubectx
  #   truss-cli
  #   # TODO: truss-local
  # ];
}
