{ inputs, cell }:
let
  inherit (inputs) cells;
  inherit (cells.home-manager) homeModules;
  inherit (cells.nix-darwin) darwinModules;
in
{

  "adam@home" = cell.lib.mkDarwinSystem {
    username = "adam";
    homeModules = with homeModules; [
      aws
      charm
      cli
      hlsdl
      iac
      k8s
      ide-full
      raycast
      syncthing
      wezterm
      mc
    ];
    darwinModules = with darwinModules; [
      fonts
      preferences
      skhd
      yabai
    ];
  };

  "adam@bridge" = cell.lib.mkDarwinSystem {
    username = "adam";
    homeModules = with homeModules; [
      aws
      cli
      iac
      k8s
      ide-full
      syncthing
      cell.homeModules.bridge
    ];
    darwinModules = with darwinModules; [
      fonts
      preferences
      skhd
      yabai
    ];
  };

}
