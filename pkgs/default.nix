# When you add custom packages, list them here
{ pkgs }: {

  hasura-cli = pkgs.callPackage ./hasura-cli { };
  kubeswitch = pkgs.callPackage ./kubeswitch { };
  kubetap = pkgs.callPackage ./kubetap { };
  trackwarrior = pkgs.callPackage ./trackwarrior { };
  truss-cli = pkgs.callPackage ./truss-cli { };

}
