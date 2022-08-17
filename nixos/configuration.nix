# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, lib, config, pkgs, ... }: {

  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware), use something like:
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # It's strongly recommended you take a look at
    # https://github.com/nixos/nixos-hardware
    # and import modules relevant to your hardware.

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    # You can also split up your configuration and import pieces of it here.
  ];

  # This will add your inputs as registries, making operations with them (such
  # as nix shell nixpkgs#name) consistent with your flake inputs.
  nix.registry = lib.mapAttrs' (n: v: lib.nameValuePair n { flake = v; }) inputs;

  # Will activate home-manager profiles for each user upon login
  # This is useful when using ephemeral installations
  environment.loginShellInit = ''
    [ -d "$HOME/.nix-profile" ] || /nix/var/nix/profiles/per-user/$USER/home-manager/activate &> /dev/null
  '';

  nix = {
    # Enable flakes and new 'nix' command
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    autoOptimiseStore = true;
  };

  # Remove if you wish to disable unfree packages for your system
  nixpkgs.config.allowUnfree = true;

  # Add the rest of your current configuration
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.utf8";
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
  };

  # Pantheon
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm.extraSeatDefaults = "user-session = pantheon";
  services.xserver.desktopManager.pantheon.enable = true;
  programs.pantheon-tweaks.enable = true;
  programs.dconf.enable = true;

  # Set your hostname
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    checkReversePath = "loose";
    interfaces.tailscale0 = {
      allowedTCPPorts = [ ];
    };
  };

  services.tailscale.enable = true;
  networking.nameservers = [ "100.100.100.100" "8.8.8.8" "1.1.1.1" ];
  networking.search = [ "enge.me.beta.tailscale.net" ];


  # Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    adam = {
      # You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      # initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      description = "Adam Engebretson";
      shell = "/home/adam/.nix-profile/bin/zsh";
      extraGroups = [ "networkmanager" "wheel" ];
      openssh.authorizedKeys.keys = [ ];
    };
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    # Forbid root login through SSH.
    permitRootLogin = "no";
    # Use keys only. Remove if you want to SSH using password (not recommended)
    passwordAuthentication = true;
  };

  environment.systemPackages = with pkgs; [
    brave
    whitesur-gtk-theme
    whitesur-icon-theme
  ];

  fileSystems."/mnt/mildred" = {
    fsType = "nfs";
    device = "10.0.2.6:/";
  };

  system.stateVersion = "22.05";
}
