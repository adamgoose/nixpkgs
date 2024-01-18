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
      # hyprland
      ide-full
      soft-serve
    ];
    nixosModules = with nixosModules; [
      k3s
      nfs
      ssh
      hlsdl
      # hydra
      podman
      netdata
      # hyprland
      # bluetooth
      buildkite
      syncthing
      tailscale
      # pulseaudio
      cell.hardwareProfiles.roxie
    ];
  };

  totoro = cell.lib.mkNixosSystem {
    name = "totoro";
    username = "adam";
    stateVersion = "23.11";
    homeModules = with homeModules; [
      cli
      ide
      k8s
    ];
    nixosModules = with nixosModules; [
      k3s
      ssh
      netdata
      tailscale
      cell.hardwareProfiles.totoro
      cell.hardwareProfiles.totoro-net
    ];
  };
}
