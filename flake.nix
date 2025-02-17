{
  description = "My personal Nix configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos.follows = "nixpkgs";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    std.url = "github:divnix/std";
    std.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin/nix-darwin-24.11";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    wsl.url = "github:nix-community/nixos-wsl/2405.5.4";
    wsl.inputs.nixpkgs.follows = "nixpkgs";

    devenv.url = "github:cachix/devenv/v1.3.1";
    hlsdl.url = "github:adamgoose/hlsdl";
    put2aria.url = "github:adamgoose/put2aria";
    # zjstatus.url = "github:dj95/zjstatus/v0.20.2";
    helix.url = "github:helix-editor/helix";
  };

  outputs = {std, ...} @ inputs:
    std.growOn
    {
      inherit inputs;
      cellsFrom = ./nix;
      cellBlocks = with std.blockTypes; [
        (installables "packages")

        (functions "lib")
        (functions "homeModules")
        (functions "hardwareProfiles")
        (functions "nixosModules")
        (functions "nixosConfigurations")
        (functions "darwinModules")
        (functions "darwinConfigurations")

        (pkgs "nixpkgs")
      ];

      nixpkgsConfig = {
        pulseaudio = true;
        allowUnfree = true;
        permittedInsecurePackages = [
          "teleport-11.3.27"
        ];
      };
    }
    {
      packages = std.harvest (inputs.self) [
        ["hasura-cli" "packages"]
        ["kubeswitch" "packages"]
        ["kubetap" "packages"]
        ["truss-cli" "packages"]
      ];

      darwinConfigurations =
        (std.harvest (inputs.self) [
          ["adam" "darwinConfigurations"]
        ])
        .aarch64-darwin;

      nixosConfigurations =
        (std.harvest (inputs.self) [
          ["adam" "nixosConfigurations"]
        ])
        .x86_64-linux;
    };

  nixConfig = {
    extra-substituters = [
      "https://devenv.cachix.org"
      "https://hyprland.cachix.org"
      "https://cache.garnix.io"
      "https://helix.cachix.org"
    ];
    extra-trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
    ];
  };
}
