{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    radicle-tui
  ];

  sops.secrets = {
    "radicle/privateKey" = {};
    "radicle/privateKeyPassphrase" = {};
    "radicle/publicKey" = {
      owner = "radicle";
    };
  };

  services.radicle = {
    enable = true;
    privateKey = config.sops.secrets."radicle/privateKey".path;
    publicKey = config.sops.secrets."radicle/publicKey".path;
    httpd = {
      enable = true;
      listenAddress = "0.0.0.0";
    };
    settings = {
      node = {
        alias = "rad.enge.me";
        listen = ["0.0.0.0:8776"];
        externalAddresses = ["totoro:8776"];
      };
    };
  };

  systemd.services.radicle-node.serviceConfig = {
    LoadCredential = [
      # "dev.radicle.node.secret:${config.sops.secrets."radicle/privateKey".path}"
      "dev.radicle.node.passphrase:${config.sops.secrets."radicle/privateKeyPassphrase".path}"
    ];
  };
}
