# When you add custom packages, list them here
{ pkgs }: {
  enc = pkgs.callPackage ./enc {};
  kotlin-language-server = pkgs.callPackage ./kotlin-language-server {};
  trackwarrior = pkgs.callPackage ./trackwarrior {};
  truss-cli = pkgs.callPackage ./truss-cli {};
  truss-local = pkgs.callPackage ./truss-local {};
}
