{ inputs, cell }:
let
  inherit (inputs) cells nixpkgs nixos hyprland home-manager;
  inherit (cells.home-manager) homeModules;
in
{
  roxie = cell.lib.mkNixosSystem {
    name = "roxie";
    username = "adam";
    stateVersion = "22.05";
    homeModules = with homeModules; [
      cli
      ide-full
      k8s
      homeModules.hyprland
    ];
    nixosModules = [
      cell.nixosModules.roxie
      # bluetooth ssh tailscale k3s nfs hyprland pulseaudio syncthing
    ];
  };
}
