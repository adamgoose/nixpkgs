{
  pkgs,
  username,
  ...
}: let
  cabundle = pkgs.cacert.override {
    extraCertificateFiles = [./netskope_ca.pem];
  };

  bundlePath = "${cabundle}/etc/ssl/certs/ca-bundle.crt";
in {
  nix = {
    extraOptions = ''
      http2 = false
      ssl-cert-file = ${bundlePath}
    '';
  };

  home-manager.users.${username}.home.sessionVariables = {
    AWS_CA_BUNDLE = bundlePath;
    CA_BUNDLE_PATH = bundlePath;
    NIX_SSL_CERT_FILE = bundlePath;
    NETSKOPE_CA_BUNDLE = bundlePath;
    NODE_EXTRA_CA_CERTS = bundlePath;
  };
}
