{ inputs, ... }:
let
  inherit (inputs) self home-manager hyprland darwin devenv nixpkgs nixpkgs-unstable;
  inherit (self) outputs;
  inherit (nixpkgs.lib) nixosSystem;
  inherit (home-manager.lib) homeManagerConfiguration;
  inherit (darwin.lib) darwinSystem;
  inherit (builtins) attrValues;
in
rec {

  mkSystem =
    { name
    , username
    , system ? "x86_64-linux"
    , features ? [ ]
    , homeFeatures ? [ ]
    , stateVersion ? "23.05"
    }: nixosSystem {
      inherit system;

      modules = [
        {
          nixpkgs.overlays = [ outputs.overlays.default ];
          system.stateVersion = stateVersion;
        }
        hyprland.nixosModules.default
        home-manager.nixosModules.home-manager
        ../nixos/configuration.nix
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit inputs outputs username;
              features = homeFeatures;
              unstable = import nixpkgs-unstable { inherit system; nixpkgs.config.allowUnfree = true; };
            };
            users.${username} = import ../home/${username};
          };
        }
      ];

      specialArgs = { inherit inputs name username features; };
    };

  mkHome =
    { name
    , username
    , system
    , features ? [ ]
    }: homeManagerConfiguration rec {
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ outputs.overlays.default ];
      };
      modules = [
        ../home/${username}
        {
          home = {
            inherit username;
            homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
          };
          programs.home-manager.enable = true;
        }
      ];
      extraSpecialArgs = {
        inherit inputs outputs name username features;
        unstable = import nixpkgs-unstable { inherit system; };
      };
    };

  mkDarwin =
    { name
    , username
    , system
    , features ? [ ]
    , homeFeatures ? [ ]
    }: darwinSystem {
      inherit system;
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ outputs.overlays.default ];
        config.allowUnfree = true;
      };
      modules = [
        ../darwin/${username}
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit inputs outputs username;
              features = homeFeatures;
              unstable = import nixpkgs-unstable { inherit system; };
            };
            # users.${username}.imports = [ ../home/${username} ];
            users.${username} = import ../home/${username};
          };
        }
      ];
      specialArgs = {
        inherit username features;
        unstable = import nixpkgs-unstable { inherit system; };
      };
    };

}
