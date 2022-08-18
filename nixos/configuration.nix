# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ inputs, lib, config, pkgs, name, features, ... }:

let
  inherit (builtins) map pathExists filter readDir;
in
{
  # Import features that have modules
  imports = filter pathExists (map (feature: ./${feature}) features);

  # Configuring Nix
  nix = {
    # Enable flakes and new 'nix' command
    extraOptions = "experimental-features = nix-command flakes";
    autoOptimiseStore = true;

    # This will add your inputs as registries, making operations with them (such
    # as nix shell nixpkgs#name) consistent with your flake inputs.
    registry = lib.mapAttrs' (n: v: lib.nameValuePair n { flake = v; }) inputs;
  };
  nixpkgs.config.allowUnfree = true;

  # Will activate home-manager profiles for each user upon login
  # This is useful when using ephemeral installations
  environment.loginShellInit = ''
    [ -d "$HOME/.nix-profile" ] || /nix/var/nix/profiles/per-user/$USER/home-manager/activate &> /dev/null
  '';

  # Configuring Locale
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.utf8";

  # Configuring Network
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = name;
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;

  # Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    adam = {
      initialPassword = "ashes disbelief exhale commute";
      isNormalUser = true;
      description = "Adam Engebretson";
      shell = "/home/adam/.nix-profile/bin/zsh";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };


  system.stateVersion = "22.05";
}
