{config, ...}: {
  sops.secrets = {
    "pangolin/newt" = {};
  };

  services.newt = {
    enable = true;
    endpoint = "https://app.pangolin.net";
    environmentFile = config.sops.secrets."pangolin/newt".path;
  };
}
