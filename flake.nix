{
  description = "You new nix config";

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org https://hyprland.cachix.org";
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";

    devenv.url = "github:cachix/devenv/latest";
    hyprland.url = "github:hyprwm/Hyprland";

    # Extra flakes for modules, packages, etc
    # hardware.url = "github:nixos/nixos-hardware"; # Convenience modules for hardware-specific quirks
  };

  outputs = inputs@{ nixpkgs, devenv, flake-parts, home-manager, ... }:
    let
      lib = import ./lib { inherit inputs; };
      inherit (lib) mkHome mkDarwin mkSystem;
      inherit (flake-parts.lib) mkFlake;
    in
    mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        packages = import ./pkgs { inherit pkgs; };
      };
      flake = {
        overlays.default = import ./overlay {
          inherit nixpkgs devenv;
        };

        homeConfigurations = {
          "adam@bridge" = mkHome {
            name = "adam@bridge";
            username = "adam";
            system = "aarch64-darwin";
            features = [ "cli" "ide-full" "aws" "k8s" "iac" "adam@bridge" "taskwarrior" ];
          };
        };

        darwinConfigurations = {
          "adam@home" = mkDarwin {
            name = "adam@home";
            username = "adam";
            system = "aarch64-darwin";
            features = [ "wm" ];
            homeFeatures = [ "cli" "ide-full" "aws" "k8s" "iac" "raycast" "alacritty" ];
          };
          "adam@bridge" = mkDarwin {
            name = "adam@bridge";
            username = "adam";
            system = "aarch64-darwin";
          };
        };

        nixosConfigurations = {
          "nixtop" = mkSystem {
            name = "nixtop";
            username = "adam";
            homeFeatures = [ "cli" "ide-full" "hyprland" ];
            features = [ "hyprland" ];
          };

          "nixvm" = mkSystem {
            name = "nixvm";
            system = "aarch64-linux";
            username = "adam";
            homeFeatures = [ "cli" "ide-full" "hyprland" ];
            features = [ "hyprland" ];
          };
        };
      };
    };

  # outputs = { nixpkgs, nixpkgs-unstable, home-manager, nix-npm-buildpackage, flake-utils, devenv, ... }@inputs:
  #   let
  #     lib = import ./lib { inherit inputs; };
  #     inherit (lib) mkSystem mkHome;
  #
  #     # Bring some functions into scope (from builtins and other flakes)
  #     inherit (builtins) attrValues;
  #     inherit (flake-utils.lib) eachSystemMap defaultSystems;
  #     eachDefaultSystemMap = eachSystemMap defaultSystems;
  #   in
  #   rec {
  #     # If you want to use packages exported from other flakes, add their overlays here.
  #     # They will be added to your 'pkgs'
  #     overlays = {
  #       default = import ./overlay {
  #         inherit nixpkgs devenv;
  #       }; # Our own overlay
  #       nix-npm-buildpackage = nix-npm-buildpackage.overlays.default;
  #       # nur = nur.overlay
  #     };
  #
  #     # System configurations
  #     # Accessible via 'nixos-rebuild'
  #     nixosConfigurations = {
  #       nixos = mkSystem {
  #         name = "nixos";
  #         features = [ "mbr" "pantheon" "ssh" "tailscale" "k3s" "nfs" ];
  #       };
  #       roxie = mkSystem {
  #         name = "roxie";
  #         features = [ "roxie" "bluetooth" "ssh" "tailscale" "k3s" "nfs" ];
  #       };
  #       nixos-vb = mkSystem {
  #         name = "nixos-vb";
  #         features = [ "mbr-vb" "pantheon" "ssh" "tailscale" ];
  #       };
  #     };
  #
  #     # Home configurations
  #     # Accessible via 'home-manager'
  #     homeConfigurations = {
  #       "adam@bridge" = mkHome {
  #         name = "adam@bridge";
  #         username = "adam";
  #         homeDirectory = "/Users/adam";
  #         system = "aarch64-darwin";
  #         features = [ "cli" "ide-full" "aws" "k8s" "iac" "adam@bridge" "taskwarrior" ];
  #       };
  #
  #       "adam@home" = mkHome {
  #         name = "adam@home";
  #         username = "adam";
  #         homeDirectory = "/Users/adam";
  #         system = "aarch64-darwin";
  #         features = [ "cli" "ide-full" "aws" "k8s" "iac" ];
  #       };
  #
  #       "gitpod" = mkHome {
  #         name = "gitpod";
  #         username = "gitpod";
  #         homeDirectory = "/home/gitpod";
  #         system = "x86_64-linux";
  #         features = [ "cli" "k8s" ];
  #       };
  #
  #       "gitpod-full" = mkHome {
  #         name = "gitpod-full";
  #         username = "gitpod";
  #         homeDirectory = "/home/gitpod";
  #         system = "x86_64-linux";
  #         features = [ "cli" "ide-full" "k8s" ];
  #       };
  #
  #       "adam@nixos" = mkHome {
  #         name = "adam@nixos";
  #         username = "adam";
  #         homeDirectory = "/home/adam";
  #         system = "x86_64-linux";
  #         features = [ "cli" "ide-full" "vscode" "k8s" "pantheon" ];
  #       };
  #
  #       "adam@roxie" = mkHome {
  #         name = "adam@roxie";
  #         username = "adam";
  #         homeDirectory = "/home/adam";
  #         system = "x86_64-linux";
  #         features = [ "cli" "ide-full" "k8s" ];
  #       };
  #
  #       "adam@nixos-vb" = mkHome {
  #         name = "adam@nixos-vb";
  #         username = "adam";
  #         homeDirectory = "/home/adam";
  #         system = "x86_64-linux";
  #         features = [ "cli" "ide-full" "k8s" "pantheon" ];
  #       };
  #
  #     };
  #
  #     # Packages
  #     # Accessible via 'nix build'
  #     packages = eachDefaultSystemMap (system:
  #       # Propagate nixpkgs' packages, with our overlays applied
  #       import nixpkgs { inherit system; overlays = attrValues overlays; config.allowUnfree = true; }
  #     );
  #
  #     packages-unstable = eachDefaultSystemMap (system:
  #       import nixpkgs-unstable { inherit system; overlays = attrValues overlays; config.allowUnfree = true; }
  #     );
  #
  #     # Devshell for bootstrapping
  #     # Accessible via 'nix develop'
  #     devShells = eachDefaultSystemMap (system: {
  #       default = import ./shell.nix { pkgs = packages.${system}; };
  #     });
  #   };
}
