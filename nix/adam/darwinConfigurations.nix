{
  inputs,
  cell,
}: let
  inherit (inputs) cells;
  inherit (cells) themes;
  inherit (cells.home-manager) homeModules;
  inherit (cells.nix-darwin) darwinModules;
in {
  "adam@home" = cell.lib.mkDarwinSystem {
    username = "adam";
    homeModules = with homeModules; [
      mc
      aws
      cli
      iac
      k8s
      charm
      helix
      hlsdl
      ghostty
      wezterm
      ide-full
      sops-bin
      syncthing
      (themes.homeModules.rose-pine {flavor = "moon";})
    ];
    darwinModules = with darwinModules; [
      fonts
      aerospace
      preferences
    ];
  };

  "adam@bridge" = cell.lib.mkDarwinSystem {
    username = "adam";
    homeModules = with homeModules; [
      aws
      cli
      iac
      k8s
      helix
      ghostty
      ide-full
      syncthing
      cell.homeModules.bridge
      (themes.homeModules.catppuccin {flavor = "macchiato";})
    ];
    darwinModules = with darwinModules; [
      fonts
      netskope
      aerospace
      preferences
      cell.darwinModules.bridge
    ];
  };
}
