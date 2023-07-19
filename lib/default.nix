{ inputs, ... }:
let
  inherit (inputs) self home-manager devenv nixpkgs nixpkgs-unstable;
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
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ outputs.overlays.default ];
      };
      modules = [
        ../home/${username}
        {
          home = {
            inherit username homeDirectory;
            stateVersion = "22.05";
          };
        }
      ];
      extraSpecialArgs = {
        inherit inputs outputs name username homeDirectory features;
        unstable = import nixpkgs-unstable { inherit system; };
      };
    };

}
