{
  description = "You new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Utilities for building our flake
    flake-utils.url = "github:numtide/flake-utils";

    # Extra flakes for modules, packages, etc
    hardware.url = "github:nixos/nixos-hardware"; # Convenience modules for hardware-specific quirks
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, flake-utils, ... }@inputs:
    let
      lib = import ./lib { inherit inputs; };
      inherit (lib) mkHome;

      # Bring some functions into scope (from builtins and other flakes)
      inherit (builtins) attrValues;
      inherit (flake-utils.lib) eachSystemMap defaultSystems;
      inherit (nixpkgs.lib) nixosSystem;
      inherit (home-manager.lib) homeManagerConfiguration;
      eachDefaultSystemMap = eachSystemMap defaultSystems;
    in
    rec {
      # If you want to use packages exported from other flakes, add their overlays here.
      # They will be added to your 'pkgs'
      overlays = {
        default = import ./overlay; # Our own overlay
        # nur = nur.overlay
      };

      # System configurations
      # Accessible via 'nixos-rebuild'
      nixosConfigurations = {
        nixos = nixosSystem {
          system = "x86_64-linux";

          modules = [
            # >> Main NixOS configuration file <<
            ./nixos/configuration.nix
            # Adds your custom NixOS modules
            ./modules/nixos
            # Adds overlays
            { nixpkgs.overlays = attrValues overlays; }
          ];
          # Make our inputs available to the config (for importing modules)
          specialArgs = { inherit inputs; };
        };
      };

      # Home configurations
      # Accessible via 'home-manager'
      homeConfigurations = {
        "adam@bridge" = mkHome {
          name = "adam@bridge";
          username = "adam";
          homeDirectory = "/Users/adam";
          system = "aarch64-darwin";
          features = [ "cli" "ide-full" "aws" "k8s" "iac" "adam@bridge" ];
        };

        "gitpod" = mkHome {
          name = "gitpod";
          username = "gitpod";
          homeDirectory = "/home/gitpod";
          system = "x86_64-linux";
          features = [ "cli" "k8s" ];
        };

        "gitpod-full" = mkHome {
          name = "gitpod-full";
          username = "gitpod";
          homeDirectory = "/home/gitpod";
          system = "x86_64-linux";
          features = [ "cli" "ide-full" "k8s" ];
        };

        "adam@nixos" = mkHome {
          name = "adam@nixos";
          username = "adam";
          homeDirectory = "/home/adam";
          system = "x86_64-linux";
          features = [ "cli" "ide-full" "k8s" ];
        };

      };

      # Packages
      # Accessible via 'nix build'
      packages = eachDefaultSystemMap (system:
        # Propagate nixpkgs' packages, with our overlays applied
        import nixpkgs { inherit system; overlays = attrValues overlays; config.allowUnfree = true; }
      );

      packages-unstable = eachDefaultSystemMap (system:
        import nixpkgs-unstable { inherit system; overlays = attrValues overlays; config.allowUnfree = true; }
      );

      # Devshell for bootstrapping
      # Accessible via 'nix develop'
      devShells = eachDefaultSystemMap (system: {
        default = import ./shell.nix { pkgs = packages.${system}; };
      });
    };
}
