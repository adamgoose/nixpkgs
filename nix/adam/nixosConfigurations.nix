{
  inputs,
  cell,
}: let
  inherit (inputs.cells) themes;
  inherit (inputs.cells.home-manager) homeModules;
  inherit (inputs.cells.nixos) nixosModules;
  windowsModules = inputs.cells.windows.nixosModules;
in {
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
      aws
      cli
      k8s
      charm
      helix
      wezterm
      hyprland
      ide-full
      qutebrowser
      (themes.homeModules.catppuccin {flavor = "macchiato";})
    ];
    nixosModules = with nixosModules; [
      k3s
      nfs
      ssh
      sops
      hlsdl
      minio
      # podman
      # netdata
      hyprland
      put2aria
      r53-ddns
      buildkite
      syncthing
      tailscale
      typesense
      pulseaudio
      cell.hardwareProfiles.totoro
    ];
  };

  redwin = cell.lib.mkNixosSystem {
    name = "redwin";
    username = "adam";
    stateVersion = "24.05";
    homeModules = with homeModules; [
      cli
      ide
      helix
      (themes.homeModules.catppuccin {flavor = "macchiato";})
    ];
    nixosModules = with windowsModules; [
      wsl
      wezterm
      komorebi
    ];
  };
}
