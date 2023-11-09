{ inputs, cell }:
let
  inherit (inputs) cells;
  inherit (cells.home-manager) homeModules;
in
{

  "adam@home" = cell.lib.mkDarwinSystem {
    username = "adam";
    homeModules = with homeModules; [
      wm
      aws
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
      sketchybar
      skhd
      yabai
    ];
  };

  "adam@bridge" = cell.lib.mkDarwinSystem {
    username = "adam";
    homeModules = with homeModules; [
      wm
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
      sketchybar
      skhd
      yabai
    ];
  };

}
