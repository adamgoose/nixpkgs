# Your overlays go here (see https://nixos.wiki/wiki/Overlays)
{ abots, devenv, ... }:
final: prev: {

  abots = abots.packages.${prev.system}.abots;
  devenv = devenv.packages.${prev.system}.devenv;

} // import ../pkgs { pkgs = final; }
