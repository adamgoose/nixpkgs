{ inputs, ... }:
let
  inherit (inputs) self home-manager;
  inherit (self) outputs;
  inherit (home-manager.lib) homeManagerConfiguration;
  inherit (builtins) attrValues;
in
rec {

  mkHome =
    { username
    , homeDirectory
    , system
    , features ? [ ]
    }:
    homeManagerConfiguration {
      inherit system username homeDirectory;
      stateVersion = "22.05";
      pkgs = outputs.packages.${system};
      extraSpecialArgs = {
        inherit inputs outputs username homeDirectory features;
      };
      configuration = ../home/${username};
      # extraModules = attrValues (import ../modules/home-manager);
    };

}