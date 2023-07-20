{ inputs, ... }:
let
  inherit (inputs) self home-manager darwin devenv nixpkgs nixpkgs-unstable;
  inherit (self) outputs;
  # inherit (nixpkgs.lib) nixosSystem;
  inherit (home-manager.lib) homeManagerConfiguration;
  inherit (darwin.lib) darwinSystem;
  inherit (builtins) attrValues;
in
rec {

  # mkSystem =
  #   { name
  #   , system ? "x86_64-linux"
  #   , features ? [ ]
  #   }: nixosSystem {
  #     inherit system;
  #
  #     modules = [
  #       ../nixos/configuration.nix
  #       ../modules/nixos
  #       { nixpkgs.overlays = attrValues outputs.overlays; }
  #     ];
  #
  #     specialArgs = { inherit inputs name features; };
  #   };

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
    {
      name
    , username
    , system
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
        inherit username;
        unstable = import nixpkgs-unstable { inherit system; };
      };
    };

}
