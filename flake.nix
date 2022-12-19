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

    nix-npm-buildpackage.url = "github:serokell/nix-npm-buildpackage";

    # Extra flakes for modules, packages, etc
    hardware.url = "github:nixos/nixos-hardware"; # Convenience modules for hardware-specific quirks
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, nix-npm-buildpackage, flake-utils, ... }@inputs:
    let
      lib = import ./lib { inherit inputs; };
      inherit (lib) mkSystem mkHome;

      # Bring some functions into scope (from builtins and other flakes)
      inherit (builtins) attrValues;
      inherit (flake-utils.lib) eachSystemMap defaultSystems;
      eachDefaultSystemMap = eachSystemMap defaultSystems;
    in
    rec {
      # If you want to use packages exported from other flakes, add their overlays here.
      # They will be added to your 'pkgs'
      overlays = {
        default = import ./overlay {
          inherit nixpkgs;
        }; # Our own overlay
        nix-npm-buildpackage = nix-npm-buildpackage.overlays.default;
        # nur = nur.overlay
      };

      # System configurations
      # Accessible via 'nixos-rebuild'
      nixosConfigurations = {
        nixos = mkSystem {
          name = "nixos";
          features = [ "mbr" "pantheon" "ssh" "tailscale" "k3s" "nfs" ];
        };
        roxie = mkSystem {
          name = "roxie";
          features = [ "roxie" "bluetooth" "ssh" "tailscale" "k3s" "nfs" "i3" ];
        };
        nixos-vb = mkSystem {
          name = "nixos-vb";
          features = [ "mbr-vb" "pantheon" "ssh" "tailscale" ];
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
          features = [ "cli" "ide-full" "vscode" "k8s" "pantheon" ];
        };

        "adam@roxie" = mkHome {
          name = "adam@roxie";
          username = "adam";
          homeDirectory = "/home/adam";
          system = "x86_64-linux";
          features = [ "cli" "ide-full" "k8s" ];
        };

        "adam@nixos-vb" = mkHome {
          name = "adam@nixos-vb";
          username = "adam";
          homeDirectory = "/home/adam";
          system = "x86_64-linux";
          features = [ "cli" "ide-full" "k8s" "pantheon" ];
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
