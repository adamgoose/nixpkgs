{config, ...}: {
  sops.secrets = {
    "teslamate/secrets" = {};
  };

  services.teslamate = {
    enable = true;
    secretsFile = config.sops.secrets."teslamate/secrets".path;
    autoStart = true;
    listenAddress = "0.0.0.0";
    port = 4000;
    virtualHost = "totoro";
    urlPath = "/";

    postgres = {
      enable_server = true;
      user = "teslamate";
      database = "teslamate";
      host = "127.0.0.1";
      port = 5432;
    };

    grafana = {
      enable = true;
      listenAddress = "0.0.0.0";
      port = 3000;
      urlPath = "/";
    };
  };
}
