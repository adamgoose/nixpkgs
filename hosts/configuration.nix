{ lib, inputs, config, pkgs, name, username, features, ... }:

let
  inherit (builtins) map pathExists filter readDir;
in
{
  imports = [
    ./${name}-hardware.nix
  ] ++ (filter pathExists (map (feature: ./${feature}) features));

  nix = {
    extraOptions = "experimental-features = nix-command flakes";
    settings.auto-optimise-store = true;
    registry = lib.mapAttrs' (n: v: lib.nameValuePair n { flake = v; }) inputs;
  };
  nixpkgs.config.allowUnfree = true;

  networking.hostName = name;
  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  programs.zsh.enable = true;
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "input" ];
    shell = pkgs.zsh;
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" ]; })
  ];
}
