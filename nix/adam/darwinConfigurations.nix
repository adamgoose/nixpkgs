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
      aws
      cli
      iac
      k8s
      charm
      helix
      ghostty
      radicle
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
}
