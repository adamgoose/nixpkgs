{
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs.cells) apple-fonts;
in {
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    montserrat
    apple-fonts.packages.default
  ];
}
