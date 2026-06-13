{
  description = "My personal Nix configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixos.follows = "nixpkgs";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    std.url = "github:divnix/std";
    std.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin/nix-darwin-26.05";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    wsl.url = "github:nix-community/nixos-wsl/2405.5.4";
    wsl.inputs.nixpkgs.follows = "nixpkgs";

    nix-openclaw.url = "github:bobberb/nix-openclaw/fix/copy-plugin-manifests";

    # zjstatus.url = "github:dj95/zjstatus/v0.20.2";
    helix.url = "github:helix-editor/helix";
    starship-jj.url = "gitlab:lanastara_foss/starship-jj/0.5.1";
    teslamate.url = "github:teslamate-org/teslamate/v2.2.0";
    teslamate.inputs.devenv-root.follows = "nixpkgs";
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
        (functions "homeConfigurations")
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
      };
    }
    {
      packages = std.harvest (inputs.self) [
        ["hasura-cli" "packages"]
        ["kubeswitch" "packages"]
      ];

      homeConfigurations =
        (std.harvest (inputs.self) [
          ["adam" "homeConfigurations"]
        ]).aarch64-darwin;

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
      "https://helix.cachix.org"
    ];
    extra-trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
    ];
  };
}
