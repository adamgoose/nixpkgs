{config, ...}: {
  sops.secrets = {
    "r53-ddns/environment" = {};
  };

  services.r53-ddns = {
    enable = true;
    ttl = 300;
    hostname = "home";
    domain = "enge.me";
    zoneID = "Z03078551JJ1PFISCN25V";
    environmentFile = config.sops.secrets."r53-ddns/environment".path;
  };
}
