{
  inputs,
  cell,
}: let
  inherit (inputs.cells.adam.lib) importModules;
in
  importModules ./.
