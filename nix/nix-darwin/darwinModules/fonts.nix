{
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs.cells) apple-fonts;
in {
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode" "FiraMono"];})
    montserrat
    apple-fonts.packages.default
  ];
}
