{
  inputs,
  cell,
}: let
  inherit (inputs) nixos darwin home-manager wsl teslamate;

  l = inputs.nixpkgs.lib // builtins;
in {
  mkNixosSystem = {
    name,
    username,
    system ? "x86_64-linux",
    stateVersion ? "23.05",
    nixosModules ? [],
    homeModules ? [],
  }:
    nixos.lib.nixosSystem {
      inherit system;

      pkgs = cell.nixpkgs.default;
      modules =
        [
          wsl.nixosModules.wsl
          teslamate.nixosModules.default
          home-manager.nixosModules.home-manager
          (cell.nixosModules.home homeModules)
          cell.nixosModules.default
          {system.stateVersion = stateVersion;}
        ]
        ++ nixosModules;

      specialArgs = {
        inherit system inputs name username;
        unstable = cell.nixpkgs.unstable;
      };
    };

  mkHome = {
    username,
    system ? "aarch64-darwin",
    homeModules ? [],
  }:
    home-manager.lib.homeManagerConfiguration {
      pkgs = cell.nixpkgs.default;
      modules =
        [
          {
            home.username = username;
            home.homeDirectory = "/Users/${username}";
            home.packages = [
              home-manager.packages.home-manager
            ];
          }
          cell.homeModules.default
        ]
        ++ homeModules;
      extraSpecialArgs = {
        inherit inputs;
        unstable = cell.nixpkgs.unstable;
      };
    };

  mkDarwinSystem = {
    username,
    system ? "aarch64-darwin",
    darwinModules ? [],
    homeModules ? [],
  }:
    darwin.lib.darwinSystem {
      inherit system;

      pkgs = cell.nixpkgs.default;
      modules =
        [
          home-manager.darwinModules.home-manager
          (cell.darwinModules.home homeModules)
          cell.darwinModules.default
        ]
        ++ darwinModules;

      specialArgs = {
        inherit inputs username;
        unstable = cell.nixpkgs.unstable;
      };
    };

  importModules = dir:
    l.mapAttrs'
    (file: type:
      l.nameValuePair
      (l.removeSuffix ".nix" file)
      (import (dir + /${file})))
    (l.filterAttrs
      (file: type: type == "directory" || file != "default.nix")
      (l.readDir dir));
}
