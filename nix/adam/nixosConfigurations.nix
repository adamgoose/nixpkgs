{ inputs, cell }:
let
  inherit (inputs) cells nixpkgs nixos hyprland home-manager;
  inherit (cells.home-manager) homeModules;

  mkSystem =
    { name
    , username
    , system ? "x86_64-linux"
    , stateVersion ? "23.05"
    , nixosModules ? [ ]
    , homeModules ? [ ]
    }: nixos.lib.nixosSystem {
      inherit system;

      modules = [
        hyprland.nixosModules.default
        home-manager.nixosModules.home-manager
        (cell.nixosModules.home homeModules)
        cell.nixosModules.default
        { system.stateVersion = stateVersion; }
      ] ++ nixosModules;

      specialArgs = {
        inherit inputs name username;
        unstable = cell.nixpkgs.unstable;
      };
    };
in
{
  roxie = mkSystem {
    name = "roxie";
    username = "adam";
    stateVersion = "22.05";
    homeModules = with homeModules; [
      cli
      ide-full
      k8s
      homeModules.hyprland
    ];
    nixosModules = [
      cell.nixosModules.roxie
    ];
  };
}
