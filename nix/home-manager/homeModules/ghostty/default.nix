{
  unstable,
  lib,
  ...
}: let
  inherit (lib) lists;
  inherit (unstable) stdenv;
in {
  home.packages = lists.optional (!stdenv.isDarwin) unstable.ghosttty;

  xdg.configFile."ghostty/config".text = ''
    font-size = 16
    font-family = FiraCode Nerd Font Mono
    background-opacity = 0.9
    background-blur-radius = 30
    mouse-scroll-multiplier = 0.1
  '';

  home.shellAliases.ghostty = "/Applications/Ghostty.app/Contents/MacOS/ghostty";
}
