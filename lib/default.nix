{ inputs, ... }:
let
  inherit (inputs) self home-manager nixpkgs;
  inherit (self) outputs;
  inherit (nixpkgs.lib) nixosSystem;
  inherit (home-manager.lib) homeManagerConfiguration;
  inherit (builtins) attrValues;
in
rec {

  mkSystem =
    { name
    , system ? "x86_64-linux"
    , features ? [ ]
    }: nixosSystem {
      inherit system;

      modules = [
        ../nixos/configuration.nix
        ../modules/nixos
        { nixpkgs.overlays = attrValues outputs.overlays; }
      ];

      specialArgs = { inherit inputs name features; };
    };

  mkHome =
    { name
    , username
    , homeDirectory
    , system
    , features ? [ ]
    }: homeManagerConfiguration {
      inherit system username homeDirectory;
      stateVersion = "22.05";
      pkgs = outputs.packages.${system};
      extraSpecialArgs = {
        inherit inputs outputs name username homeDirectory features;
        unstable = outputs.packages-unstable.${system};
      };
      configuration = ../home/${username};
      # extraModules = attrValues (import ../modules/home-manager);
    };

}
