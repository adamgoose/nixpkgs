# When you add custom packages, list them here
{ pkgs }: {
  kubectx = pkgs.callPackage ./kubectx {};
  oh-my-posh = pkgs.callPackage ./oh-my-posh {};
  tere = pkgs.callPackage ./tere {};
  trackwarrior = pkgs.callPackage ./trackwarrior {};
  truss-cli = pkgs.callPackage ./truss-cli {};
  truss-local = pkgs.callPackage ./truss-local {};
  kotlin-language-server = pkgs.callPackage ./kotlin-language-server {};
}
