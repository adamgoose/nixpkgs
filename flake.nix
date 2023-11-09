{
  description = "My personal Nix configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixos.follows = "nixpkgs";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    std.url = "github:divnix/std";
    std.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    devenv.url = "github:cachix/devenv/latest";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { std, ... }@inputs: std.growOn
    {
      inherit inputs;
      cellsFrom = ./nix;
      cellBlocks = with std.blockTypes; [
        (installables "packages")

        (functions "lib")
        (functions "homeModules")
        (functions "nixosModules")
        (functions "nixosConfigurations")
        (functions "darwinModules")
        (functions "darwinConfigurations")

        (pkgs "nixpkgs")
      ];

      nixpkgsConfig = {
        allowUnfree = true;
      };
    }
    {
      packages = std.harvest (inputs.self) [
        [ "hasura-cli" "packages" ]
        [ "kubeswitch" "packages" ]
        [ "kubetap" "packages" ]
        [ "truss-cli" "packages" ]
      ];

      darwinConfigurations = (std.harvest (inputs.self) [
        [ "adam" "darwinConfigurations" ]
      ]).aarch64-darwin;

      nixosConfigurations = (std.harvest (inputs.self) [
        [ "adam" "nixosConfigurations" ]
      ]).x86_64-linux;
    };

  nixConfig = {
    extra-substituters = [
      "https://devenv.cachix.org"
      "https://hyprland.cachix.org"
      "https://cache.garnix.io"
    ];
    extra-trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };

  # outputs = inputs@{ nixpkgs, devenv, abots, flake-parts, home-manager, ... }:
  #   let
  #     lib = import ./lib { inherit inputs; };
  #     inherit (lib) mkHome mkDarwin mkSystem;
  #     inherit (flake-parts.lib) mkFlake;
  #   in
  #   mkFlake { inherit inputs; } {
  #     systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
  #     perSystem = { config, self', inputs', pkgs, system, ... }: {
  #       packages = import ./pkgs { inherit pkgs; };
  #     };
  #     flake = {
  #       overlays.default = import ./overlay {
  #         inherit nixpkgs devenv abots;
  #       };
  #
  #       homeConfigurations = { };
  #
  #       darwinConfigurations = {
  #         "adam@home" = mkDarwin {
  #           name = "adam@home";
  #           username = "adam";
  #           system = "aarch64-darwin";
  #           features = [ "wm" ];
  #           homeFeatures = [ "cli" "ide-full" "aws" "k8s" "iac" "raycast" "alacritty" "syncthing" "wm" ];
  #         };
  #         "adam@bridge" = mkDarwin {
  #           name = "adam@bridge";
  #           username = "adam";
  #           system = "aarch64-darwin";
  #           features = [ "wm" ];
  #           homeFeatures = [ "cli" "ide-full" "aws" "k8s" "iac" "adam@bridge" "taskwarrior" "wm" ];
  #         };
  #       };
  #
  #       nixosConfigurations = {
  #         "nixtop" = mkSystem {
  #           name = "nixtop";
  #           username = "adam";
  #           homeFeatures = [ "cli" "ide-full" "hyprland-nvidia" ];
  #           features = [ "hyprland" ];
  #         };
  #
  #         "roxie" = mkSystem {
  #           name = "roxie";
  #           username = "adam";
  #           homeFeatures = [ "cli" "ide-full" "k8s" "hyprland" ];
  #           features = [ "roxie" "bluetooth" "ssh" "tailscale" "k3s" "nfs" "hyprland" "pulseaudio" "syncthing" ];
  #           stateVersion = "22.05";
  #         };
  #       };
  #     };
  #   };
}
