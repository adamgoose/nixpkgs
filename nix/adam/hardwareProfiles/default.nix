{
  inputs,
  cell,
}: let
  inherit (cell.lib) importModules;
in
  importModules ./.
