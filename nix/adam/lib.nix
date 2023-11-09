{ inputs, cell }:
let
  inherit (inputs) cells nixos darwin hyprland home-manager;
in
{

  mkNixosSystem =
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


  mkDarwinSystem =
    { username
    , system ? "aarch64-darwin"
    , darwinModules ? [ ]
    , homeModules ? [ ]
    }: darwin.lib.darwinSystem {
      inherit system;

      pkgs = cell.nixpkgs.default;
      modules = [
        cells.pam-tid.darwinModules.default
        home-manager.darwinModules.home-manager
        (cell.darwinModules.home homeModules)
        cell.darwinModules.default
      ] ++ darwinModules;

      specialArgs = {
        inherit inputs username;
        unstable = cell.nixpkgs.unstable;
      };
    };

}
