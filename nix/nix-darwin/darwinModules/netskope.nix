{ unstable, username, ... }:
let
  pkgs = unstable;
  cabundle = pkgs.cacert.override {
    extraCertificateFiles = [ ./netskope_ca.pem ];
  };
in
{
  nix = {
    extraOptions = ''
      ssl-cert-file = ${cabundle}/etc/ssl/certs/ca-bundle.crt
    '';
  };

  home-manager.users.${username}.home.sessionVariables = {
    AWS_CA_BUNDLE = "${cabundle}/etc/ssl/certs/ca-bundle.crt";
    NODE_EXTRA_CA_CERTS = "${cabundle}/etc/ssl/certs/ca-bundle.crt";
  };
}
