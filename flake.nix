{
  description = "You new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Utilities for building our flake
    flake-utils.url = "github:numtide/flake-utils";

    # Extra flakes for modules, packages, etc
    hardware.url = "github:nixos/nixos-hardware"; # Convenience modules for hardware-specific quirks
  };

  outputs = { nixpkgs, home-manager, flake-utils, ... }@inputs:
    let
      # Bring some functions into scope (from builtins and other flakes)
      inherit (builtins) attrValues;
      inherit (flake-utils.lib) eachSystemMap defaultSystems;
      inherit (nixpkgs.lib) nixosSystem;
      inherit (home-manager.lib) homeManagerConfiguration;
      eachDefaultSystemMap = eachSystemMap defaultSystems;
    in
    rec {
      # TODO: If you want to use packages exported from other flakes, add their overlays here.
      # They will be added to your 'pkgs'
      overlays = {
        default = import ./overlay; # Our own overlay
        # nur = nur.overlay
      };

      # System configurations
      # Accessible via 'nixos-rebuild'
      nixosConfigurations = {
        # FIXME: Replace with your hostname
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
        "adam@nixos" = homeManagerConfiguration rec {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          # modules =[
          #   ./modules/home-manager
          #   { nixpkgs.overlays = attrValues overlays; }
          #   ./home-manager/home.nix
          #   {
          #     home = {
          #       username = "adam";
          #       homeDirectory = "/home/adam";

          #     };
          #   }
          # ];

          system = "x86_64-linux";
          username = "adam";
          homeDirectory = "/home/${username}";
          stateVersion = "22.05";

          # >> Main home-manager configuration file <<
          configuration = ./home-manager/home.nix;
          extraModules = [
            # Adds your custom home-manager modules
            ./modules/home-manager
            # Adds overlays
            { nixpkgs.overlays = attrValues overlays; }
          ];
          # Make our inputs available to the config (for importing modules)
          extraSpecialArgs = { inherit inputs; };
        };
      };

      # Packages
      # Accessible via 'nix build'
      packages = eachDefaultSystemMap (system:
        # Propagate nixpkgs' packages, with our overlays applied
        import nixpkgs { inherit system; overlays = attrValues overlays; }
      );

      # Devshell for bootstrapping
      # Accessible via 'nix develop'
      devShells = eachDefaultSystemMap (system: {
        default = import ./shell.nix { pkgs = packages.${system}; };
      });
    };
}
