{
  inputs,
  cell,
}: let
  inherit (inputs.cells) themes;
  inherit (inputs.cells.home-manager) homeModules;
in {
  "adam@work" = cell.lib.mkHome {
    username = "adamengebretson";
    homeModules = with homeModules; [
      cli
      helix
      ghostty
      ide-full
      cell.homeModules.thma
      (themes.homeModules.rose-pine {flavor = "moon";})
    ];
  };
}
