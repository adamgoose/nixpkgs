# When you add custom packages, list them here
{ pkgs }: {
  kubectx = pkgs.callPackage ./kubectx {};
  oh-my-posh = pkgs.callPackage ./oh-my-posh {};
  # example = pkgs.callPackage ./example { };
}
