{ inputs, cell }:
let
  inherit (inputs) self cells darwin nixpkgs home-manager;
  inherit (cells.home-manager) homeModules;
  mkDarwin =
    { username
    , system ? "aarch64-darwin"
    , darwinModules ? [ ]
    , homeModules ? [ ]
    }: darwin.lib.darwinSystem {
      inherit system;

      pkgs = nixpkgs;
      modules = [
        cells.pam-tid.darwinModules.default
        home-manager.darwinModules.home-manager
        (cell.darwinModules.home homeModules)
        cell.darwinModules.default
      ] ++ darwinModules;

      specialArgs = {
        inherit inputs username;
        unstable = cell.nixpkgs.unstable;
      };
    };
in
{

  "adam@home" = mkDarwin {
    username = "adam";
    homeModules = with homeModules; [
      wm
      aws
      cli
      iac
      k8s
      ide-full
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

  "adam@bridge" = mkDarwin {
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
