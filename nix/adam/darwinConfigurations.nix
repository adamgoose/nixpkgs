{ inputs, cell }:
let
  inherit (inputs) cells;
  inherit (cells.home-manager) homeModules;
in
{

  "adam@home" = cell.lib.mkDarwinSystem {
    username = "adam";
    homeModules = with homeModules; [
      aws
      charm
      cli
      iac
      k8s
      ide-full
      raycast
      syncthing
    ];
    darwinModules = with cell.darwinModules; [
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
      cell.homeModules.bridge
    ];
    darwinModules = with cell.darwinModules; [
      fonts
      preferences
      skhd
      yabai
    ];
  };

}
