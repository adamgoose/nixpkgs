{ inputs, cell }:
let
  inherit (inputs.cells) home-manager;
in
{

  default = { pkgs, name, username, ... }: {
    nix = {
      extraOptions = "experimental-features = nix-command flakes repl-flake";
      settings.auto-optimise-store = true;
      settings.trusted-users = [ "root" username ];
      # registry = lib.mapAttrs' (n: v: lib.nameValuePair n { flake = v; }) inputs;
    };

    networking.hostName = name;
    # networking.networkmanager.enable = true;

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
      initialPassword = "applesauce";
      extraGroups = [ "networkmanager" "wheel" "input" ];
      shell = pkgs.zsh;
    };
  };

  home = modules:
    home-manager.nixosModules.mkNixOSModule ([
      cell.homeModules.default
    ] ++ modules);

}
