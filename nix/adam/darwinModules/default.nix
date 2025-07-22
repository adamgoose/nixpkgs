{
  inputs,
  cell,
}: let
  inherit (inputs.cells) home-manager;
in {
  default = {
    pkgs,
    username,
    ...
  }: {
    nix = {
      settings = {
        trusted-users = ["root" username];
      };
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
      registry = {
        nixpkgs.flake = inputs.nixpkgs;
      };
    };

    nixpkgs.config = {
      allowUnfree = true;
    };

    programs.zsh.enable = true;
    environment = {
      shells = [pkgs.zsh];
    };

    system.primaryUser = username;
    users.users.${username} = {
      name = username;
      home = "/Users/${username}";
    };

    ids.gids.nixbld = 350;

    system.stateVersion = 4;
  };

  bridge = {lib, ...}: {
    ids.gids.nixbld = lib.mkForce 30000;
  };

  home = modules:
    home-manager.darwinModules.mkDarwinModule ([
        cell.homeModules.default
      ]
      ++ modules);
}
