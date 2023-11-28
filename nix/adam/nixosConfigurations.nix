{ inputs, cell }:
let
  inherit (inputs.cells.home-manager) homeModules;
  inherit (inputs.cells.nixos) nixosModules;
in
{
  roxie = cell.lib.mkNixosSystem {
    name = "roxie";
    username = "adam";
    stateVersion = "22.05";
    homeModules = with homeModules; [
      cli
      k8s
      hyprland
      ide-full
      soft-serve
    ];
    nixosModules = with nixosModules; [
      k3s
      nfs
      ssh
      hlsdl
      hydra
      podman
      netdata
      hyprland
      bluetooth
      syncthing
      tailscale
      pulseaudio
      cell.hardwareProfiles.roxie
    ];
  };
}
