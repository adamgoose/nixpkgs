{
  unstable,
  username,
  ...
}: let
  pkgs = unstable;
  cabundle = pkgs.cacert.override {
    extraCertificateFiles = [./netskope_ca.pem];
  };

  bundlePath = "${cabundle}/etc/ssl/certs/ca-bundle.crt";
in {
  nix = {
    extraOptions = ''
      ssl-cert-file = ${bundlePath}
    '';
  };

  home-manager.users.${username}.home.sessionVariables = {
    AWS_CA_BUNDLE = bundlePath;
    NETSCKOPE_CA_BUNDLE = bundlePath;
    NODE_EXTRA_CA_CERTS = bundlePath;
  };
}
