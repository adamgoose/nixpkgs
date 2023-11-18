{ pkgs, inputs, ... }:
let
  inherit (inputs.cells) apple-fonts;
in
{

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" ]; })
    montserrat
    apple-fonts.packages.default
  ];

}
