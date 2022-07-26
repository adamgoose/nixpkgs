# When you add custom packages, list them here
{ pkgs }: {
  kubectx = pkgs.callPackage ./kubectx {};
  oh-my-posh = pkgs.callPackage ./oh-my-posh {};
  tere = pkgs.callPackage ./tere {};
  truss-cli = pkgs.callPackage ./truss-cli {};
}
