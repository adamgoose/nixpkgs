{ inputs, cell }:
let
  inherit (inputs) cells nixpkgs nixos hyprland home-manager;
  inherit (cells.home-manager) homeModules;
  inherit (cells.nixos) nixosModules;
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
    nixosModules = with nixosModules; [
      k3s
      nfs
      ssh
      bluetooth
      syncthing
      tailscale
      pulseaudio
      nixosModules.hyprland
      cell.hardwareProfiles.roxie
    ];
  };
}
