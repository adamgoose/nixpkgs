# Your overlays go here (see https://nixos.wiki/wiki/Overlays)
{ devenv, ... }:
final: prev: {

  devenv = devenv.packages.${prev.system}.devenv;

} // import ../pkgs { pkgs = final; }
